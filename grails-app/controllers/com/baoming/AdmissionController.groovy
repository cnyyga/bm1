package com.baoming

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.transaction.annotation.Transactional

class AdmissionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def downloadService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = 'id'
        params.order = 'desc'
        def closure =  {
            if(params.name){
                or{
                    'like'('name',"%${params.name}%")
                    eq('idNo',params.name)
                }
            }
        }
        def count = Admission.createCriteria().count(closure)
        def list = count>0?Admission.createCriteria().list(params,closure):[]
        [admissionInstanceList:list, admissionInstanceTotal: count]
    }

    def create() {
        [admissionInstance: new Admission(params)]
    }

    def save() {
        def admissionInstance = new Admission(params)
        if (!admissionInstance.save(flush: true)) {
            render(view: "create", model: [admissionInstance: admissionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'admission.label', default: 'Admission'), admissionInstance.id])
        redirect(action: "show", id: admissionInstance.id)
    }

    def show(Long id) {
        def admissionInstance = Admission.get(id)
        if (!admissionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "list")
            return
        }

        [admissionInstance: admissionInstance]
    }

    def edit(Long id) {
        def admissionInstance = Admission.get(id)
        if (!admissionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "list")
            return
        }

        [admissionInstance: admissionInstance]
    }

    def update(Long id, Long version) {
        def admissionInstance = Admission.get(id)
        if (!admissionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (admissionInstance.version > version) {
                admissionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'admission.label', default: 'Admission')] as Object[],
                          "Another user has updated this Admission while you were editing")
                render(view: "edit", model: [admissionInstance: admissionInstance])
                return
            }
        }

        admissionInstance.properties = params

        if (!admissionInstance.save(flush: true)) {
            render(view: "edit", model: [admissionInstance: admissionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'admission.label', default: 'Admission'), admissionInstance.id])
        redirect(action: "show", id: admissionInstance.id)
    }

    def delete(Long id) {
        def admissionInstance = Admission.get(id)
        if (!admissionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "list")
            return
        }

        try {
            admissionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'admission.label', default: 'Admission'), id])
            redirect(action: "show", id: id)
        }
    }

    def importFile(){
        render(view: 'import')
    }

    def saveImport(){
        def file = request.getFile("file")
        if (!file || file.empty) {
            flash.message = message(code: 'admission.file.notNull.message')
            return
        }
        def list = downloadService.getExcelToList(file.inputStream)
        if(!list) {
            flash.message = message(code: 'admission.not.null.message')
            return
        }
        list.each {l->
            def idNo = l[0]
            def name = l[1]
            def sex = l[2]
            def ksh = l[3]
            def bkzy = l[4]
            def jtdz = l[5]
            def lxdh = l[6]
            def kd = l[7]
            def kddh = l[8]
            def bz = l[9]
            if(!idNo){
                println("身份证号不能为空")
                return
            }
            def admission = Admission.findOrCreateByIdNo(idNo)
            admission.name = name
            admission.sex = sex
            admission.ksh = ksh
            admission.bkzy = bkzy
            admission.jtdz = jtdz
            admission.lxdh = lxdh
            admission.kd = kd
            admission.kddh = kddh
            admission.bz = bz
            if(!admission.save(flush: true)){
                println("idno:${idNo}，保存失败")
            }
        }
        flash.message = message(code: 'default.save.success.label')
        render(view: 'import')
    }
}
