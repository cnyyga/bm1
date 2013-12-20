package com.baoming

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.baoming.account.Role
import com.baoming.account.Teacher
import grails.converters.JSON
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils
import jxl.format.Colour

class StatisticsController {

    def springSecurityService
    def homeService

    def index() {


    }

    def yearForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfYear(teacher)
        render((sn as JSON) as String)
    }

    def genderForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfGender(startDate,endDate,teacher)
        render((sn as JSON) as String)
    }

    def cityForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfCity(startDate,endDate,teacher)
        render((sn as JSON) as String)
    }

    def middleSchoolForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfMiddleSchool(startDate,endDate,teacher)
        render((sn as JSON) as String)
    }

    def reviewStatusForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfReviewStatus(startDate,endDate,teacher)
        render((sn as JSON) as String)
    }
    def teacherForAjax(){
        def year = params.date('year','yyyy')
        def startDate
        def endDate
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            teacher = Teacher.get(userId)
        } else if (params.teacherId){
            teacher = Teacher.get(params.teacherId)
        }

        def sn = homeService.getStudentNumberChartOfTeacher(startDate,endDate,teacher)
        render((sn as JSON) as String)
    }

    def statisticsService

    def teacherStat(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def offset = params.offset?params.int('offset'):0
        def date = params.date('date','yyyy-MM-dd')
        date= date?:new Date()
        params.date = date.format('yyyy-MM-dd')
        def list = statisticsService.teacherStat(date,params.max,offset)
        [teachers:list,date:date,total:Teacher.count()]
    }

    def expTeacherStat() {
        def date = params.date('date','yyyy-MM-dd')
        date= date?:new Date()
        def list = statisticsService.teacherStat(date,Teacher.count())
        def outputStream
        def titles = [message(code: 'statistics.sort.label'),message(code: 'statistics.teacher.name.label')]
        titles << message(code: 'statistics.teacher.area.label')
        titles << message(code: 'teacher.taskNumber.label')
        titles << message(code: 'statistics.today.number.label')
        titles << message(code: 'statistics.total.number.label')
        titles << message(code: 'statistics.date.label')
        titles << message(code: 'statistics.department.name.label')

        try {
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'statistics.teacher.label')}${date.format('yyyy-MM-dd')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {

                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold().font.colour=Colour.RED
                    }
                    list.eachWithIndex {de,k->
                        def kk = k+1
                        def teacher = de[0]
                        def teacherDistricts = teacher.teacherDistricts
                        teacherDistricts = teacherDistricts.collect{td->
                            "${td.district?.city?.name}${td.district?.name}"
                        }
                        cell(0,kk,kk)//序号
                        cell(1,kk,teacher.name?:'') //老师名称
                        cell(2,kk,teacherDistricts.join(',')?:'') //老师地区
                        cell(3,kk,teacher.taskNumber?:'') //任务数
                        cell(4,kk,de[1]?:0) //今天完成数
                        cell(5,kk,de[2]?:0) //累计完成数
                        cell(6,kk,date.format('yyyy-MM-dd')) //日期
                        cell(7,kk,teacher.department?.name?:'') //部门
                    }
                }
            }
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Student exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }

    def expDepartmentStat() {
        def date = params.date('date','yyyy-MM-dd')
        date= date?:new Date()
        def list = statisticsService.departmentStat(date,Department.count())
        def outputStream
        def titles = [message(code: 'statistics.sort.label')]
        titles << message(code: 'statistics.department.name.label')
        titles << message(code: 'department.taskNumber.label')
        titles << message(code: 'statistics.today.number.label')
        titles << message(code: 'statistics.total.number.label')
        titles << message(code: 'statistics.date.label')

        try {
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'statistics.department.label')}${date.format('yyyy-MM-dd')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold().font.colour=Colour.RED
                    }
                    list.eachWithIndex {de,k->
                        def kk = k+1
                        cell(0,kk,kk)//序号
                        cell(1,kk,de[0]?:'') //部门
                        cell(2,kk,de[1]?:0) //任务数
                        cell(3,kk,de[2]?:0) //今天完成数
                        cell(4,kk,de[3]?:0) //累计完成数
                        cell(5,kk,date.format('yyyy-MM-dd')) //日期
                    }
                }
            }
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Student exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }

    def departmentStat(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def offset = params.offset?params.int('offset'):0
        def date = params.date('date','yyyy-MM-dd')
        date= date?:new Date()
        params.date = date.format('yyyy-MM-dd')
        def list = statisticsService.departmentStat(date,params.max,offset)
        [departments:list,date:date,total:Department.count()]
    }
}
