package com.baoming

import com.baoming.account.Role
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.FileUtils
import org.apache.commons.io.IOUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class WorkPlanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def userId = springSecurityService.authentication.principal?.id

        def list = []
        def count = 0
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            list = WorkPlan.createCriteria().list(params) {
                eq('teacherId',userId)
            }
            count = WorkPlan.createCriteria().count {
                eq('teacherId',userId)
            }
        }else{
            list = WorkPlan.list(params)
            count = WorkPlan.count()
        }
        params.max = Math.min(max ?: 10, 100)
        [workPlanInstanceList: list, workPlanInstanceTotal: count]
    }

    def create() {
        [workPlanInstance: new WorkPlan(params)]
    }

    def save() {
        def workPlanInstance = new WorkPlan(params)
        def cal = Calendar.instance
        def userId = springSecurityService.authentication.principal?.id
        workPlanInstance.teacherId = userId as long
        workPlanInstance.year = cal.get(Calendar.YEAR)

        def file = request.getFile("fileInp")
        if(file &&  !file.empty) {
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "${UUID.randomUUID().toString()}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            workPlanInstance.pic = storeName1
        }

        workPlanInstance.validate()
        if (!workPlanInstance.save(flush: true)) {
            render(view: "create", model: [workPlanInstance: workPlanInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlanInstance.id])
        redirect(action: "show", id: workPlanInstance.id)
    }

    def show(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }
        def cal = Calendar.instance
        def userId = springSecurityService.authentication.principal?.id
        workPlanInstance.teacherId = userId
        workPlanInstance.year = cal.get(Calendar.YEAR)
        [workPlanInstance: workPlanInstance]
    }

    def edit(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        [workPlanInstance: workPlanInstance]
    }

    def update(Long id, Long version) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (workPlanInstance.version > version) {
                workPlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'workPlan.label', default: 'WorkPlan')] as Object[],
                        "Another user has updated this WorkPlan while you were editing")
                render(view: "edit", model: [workPlanInstance: workPlanInstance])
                return
            }
        }

        workPlanInstance.properties = params
        def cal = Calendar.instance
        def userId = springSecurityService.authentication.principal?.id
        workPlanInstance.teacherId = userId
        workPlanInstance.year = cal.get(Calendar.YEAR)

        def file = request.getFile("fileInp")
        if(file &&  !file.empty) {
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "${UUID.randomUUID().toString()}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            workPlanInstance.pic = storeName1
        }

        workPlanInstance.validate()
        if (!workPlanInstance.save(flush: true)) {
            render(view: "edit", model: [workPlanInstance: workPlanInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlanInstance.id])
        redirect(action: "show", id: workPlanInstance.id)
    }

    def exp() {
        def userId = springSecurityService.authentication.principal?.id
        def list = []
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            list = WorkPlan.createCriteria().list() {
                eq('teacherId',userId)
            }
        }else{
            list = WorkPlan.list()
        }
        def outputStream
        try{
            def dataMap = getDatas(list)
            def datas =  dataMap.datas
            def titles = dataMap.titles
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'workPlan.label')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold()
                    }
                    datas.eachWithIndex {de,k->
                        def kk = k+1
                        de.eachWithIndex{s,j->
                            cell(j,kk,s?:' ')
                        }
                    }
                }
            }
        }catch (e){
            flash.message = message(code: 'download.null.message')
            log.error("Student exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return

    }

    private getDatas(def list) {
        def datas = []
        def title = []
        list.eachWithIndex {workPlan,i->
            def data = []
            def wp = workPlan as WorkPlan
                if(i ==0 ){
                    title << message(code: 'workPlan.name.label')
                    title << message(code: 'workPlan.area.label')
                    title << message(code: 'workPlan.num.label')
                    title << message(code: 'workPlan.date.label')
                    title << message(code: 'workPlan.middleSchools.label')
                    title << message(code: 'workPlan.tel.label')
                    title << message(code: 'workPlan.result.label')
                    title << message(code: 'workPlan.opinion.label')
                    title << message(code: 'workPlan.materialObject.label')
                    title << message(code: 'workPlan.materialNum.label')
                    title << message(code: 'workPlan.materialTel.label')
                    title << message(code: 'workPlan.questions.label')
                    title << message(code: 'workPlan.hasOpinion.label')
                    title << message(code: 'workPlan.pic.label')
                    title << message(code: 'workPlan.carFare.label')
                    title << message(code: 'workPlan.cityCarFare.label')
                    title << message(code: 'workPlan.accommodation.label')
                    title << message(code: 'workPlan.entertainment.label')
                    title << message(code: 'workPlan.amount.label')
                    title << message(code: 'workPlan.attendSeminar.label')
                    title << message(code: 'workPlan.workPlan.label')
                    title << message(code: 'workPlan.dateCreated.label')
                }
            data << wp.name
            data << wp.area
            data << wp.num
            data << "${wp.startDate?.format('yyyy/MM/dd')} - ${wp.endDate?.format('yyyy/MM/dd')}"
            data << wp.middleSchools
            data << wp.tel
            data << wp.result
            data << wp.opinion
            data << wp.materialObject
            data << wp.materialNum
            data << wp.materialTel
            data << wp.questions
            data << (wp.hasOpinion == 1?message(code:'default.yes.label'):message(code:'default.no.label'))
            data << wp.pic
            data << wp.carFare
            data << wp.cityCarFare
            data << wp.accommodation
            data << wp.entertainment
            data << wp.amount
            data << (wp.attendSeminar == 1?message(code:'default.yes.label'):message(code:'default.no.label'))
            data << wp.workPlan
            data << wp.dateCreated.format('yyyy/MM/dd')
            datas << data
        }
        return [titles:title,datas:datas]
    }

    def delete(Long id) {
        def workPlanInstance = WorkPlan.get(id)
        if (!workPlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
            return
        }

        try {
            workPlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), id])
            redirect(action: "show", id: id)
        }
    }
}
