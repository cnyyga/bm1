package com.baoming

import com.baoming.account.Role
import com.baoming.account.Teacher
import grails.converters.JSON
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class PreppyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def total
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        if (!year) {
            cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time
        } else {
            cal.time = year
            cal.add(Calendar.YEAR, 1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }

        list = Preppy.createCriteria().list(params) {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }
        total = Preppy.createCriteria().count {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }

        params.max = Math.min(max ?: 10, 100)
        [preppyInstanceList: list, preppyInstanceTotal: total]
    }

    def create() {
        [preppyInstance: new Preppy(params)]
    }

    def save() {
        def preppyInstance = new Preppy(params)
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
        }

        if (!preppyInstance.save(flush: true)) {
            render(view: "create", model: [preppyInstance: preppyInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def show(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance]
    }

    def edit(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance]
    }

    def update(Long id, Long version) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (preppyInstance.version > version) {
                preppyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'preppy.label', default: 'Preppy')] as Object[],
                        "Another user has updated this Preppy while you were editing")
                render(view: "edit", model: [preppyInstance: preppyInstance])
                return
            }
        }

        preppyInstance.properties = params

        if (!preppyInstance.save(flush: true)) {
            render(view: "edit", model: [preppyInstance: preppyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def delete(Long id) {
        def preppyInstance
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
            preppyInstance = Preppy.findByIdAndTeacher(id, teacher)
        } else {
            preppyInstance = Preppy.get(id)
        }
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 0] as JSON) as String)
            return
        }

        try {
            preppyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 1] as JSON) as String)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 0] as JSON) as String)
        }
    }

    def exp(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        if (!year) {
            cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time
        } else {
            cal.time = year
            cal.add(Calendar.YEAR, 1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }

        list = Preppy.createCriteria().list {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)

        }
        def titles = [message(code: 'preppy.name.label'),message(code: 'preppy.gender.label'),message(code: 'preppy.number.label'),
                      message(code: 'preppy.collegeType.label'),message(code: 'preppy.status.label'),message(code: 'preppy.middlePlan.label'),
                      message(code: 'preppy.plan.label'),message(code: 'preppy.family.label'),message(code: 'preppy.phone.label'),
                      message(code: 'preppy.qq.label'),message(code: 'preppy.tel.label'),message(code: 'preppy.teacher.label'),
                      message(code: 'default.lastUpdated.label')]
        def outputStream
        try {

            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'preppy.label')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold()
                    }
                    list.eachWithIndex {de,k->
                        def kk = k+1
                        cell(0,kk,de.name?:'')
                        cell(1,kk,de.gender?.label?:'')
                        cell(2,kk,de.number?:'')
                        cell(3,kk,de.collegeType?.label?:'')
                        cell(4,kk,de.status?.label?:'')
                        cell(5,kk,de.middlePlan?:'')
                        cell(6,kk,de.plan?.name?:'')
                        cell(7,kk,de.family?.label?:'')
                        cell(8,kk,de.phone?:'')
                        cell(9,kk,de.qq?:'')
                        cell(10,kk,de.tel?:'')
                        try {
                            cell(11,kk,de.teacher?.name?:'')
                        } catch (Exception e) {
                            cell(11,kk,'')
                        }
                        cell(12,kk,de.lastUpdated.format('yyyy-MM-dd HH:mm:ss'))
                    }
                }
            }
            //
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Preppy exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }
}
