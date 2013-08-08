package bm

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.baoming.account.Role
import com.baoming.account.Teacher
import com.baoming.account.Student
import groovy.sql.Sql
import org.apache.commons.io.IOUtils
import grails.plugin.jxl.builder.ExcelBuilder

class HomeController {
   def homeService
    def springSecurityService
    def index() {
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
        }
        def total = homeService.getStudentCount(startDate,endDate,teacher)
        def pass = homeService.getStudentCount(startDate,endDate,teacher,Student.ReviewStatus.PASS)
        def audit = homeService.getStudentCount(startDate,endDate,teacher,Student.ReviewStatus.NO_AUDIT)
        def nopass = homeService.getStudentCount(startDate,endDate,teacher,Student.ReviewStatus.NO_PASS)
        def teachers = homeService.getSutdentsForTeacher(0,10,startDate,endDate)
        def districts = homeService.getSutdentsForCity(startDate,endDate,teacher)
        def plans = homeService.getStudentsForPlan(startDate,endDate,teacher)
        def citys = SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)?[]:homeService.getStudentCountForCity1(startDate,endDate)
        def middles = SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)?[]:homeService.getStudentsForMiddleSchool(0,10,startDate,endDate)
        [total:total,pass:pass,audit:audit,noPass:nopass,teachers:teachers,citys:citys,plans:plans,districts:districts,middleSchools:middles]
    }

    def rank(Integer max) {
        def t = params.t
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
        }
        params.max = Math.min(max ?: 10, 100)
        params.offset = params.offset?params.int('offset'):0
        def offset = params.offset + 1
        def m = [objs:[],total: 0]
        def label = ''
        switch (t){
             case 'teacher':
                 m = homeService.getStudentCountForTeacher(offset,params.max,startDate,endDate)
                 label = message(code: 'teacher.label')
                break
            case 'district':
                m = homeService.getStudentCountForDistrict(offset,params.max,startDate,endDate,teacher)
                label = message(code: 'district.label')
                break
            case 'plan':
                m = homeService.getStudentCountForPlan(offset,params.max,startDate,endDate,teacher)
                label = message(code: 'plan.label')
                break
            case 'middleSchool':
                m = homeService.getStudentCountForMiddleSchool(offset,params.max,startDate,endDate,teacher)
                label = message(code: 'middleSchool.label')
                break
            case 'city':
                m = homeService.getStudentCountForCity(offset,params.max,startDate,endDate)
                label = message(code: 'city.label')
                break
        }
        m.label = label
        render(view: 'teacherRank',model:m)
    }

    def export(Integer max) {
        def t = params.t
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
        }
        params.max = 10000
        params.offset = 0
        def m = [objs:[],total: 0]
        def label = ''
        switch (t){
            case 'teacher':
                m = homeService.getStudentCountForTeacher(params.offset,params.max,startDate,endDate)
                label = message(code: 'teacher.label')
                break
            case 'district':
                m = homeService.getStudentCountForDistrict(params.offset,params.max,startDate,endDate,teacher)
                label = message(code: 'district.label')
                break
            case 'plan':
                m = homeService.getStudentCountForPlan(params.offset,params.max,startDate,endDate,teacher)
                label = message(code: 'plan.label')
                break
            case 'middleSchool':
                m = homeService.getStudentCountForMiddleSchool(params.offset,params.max,startDate,endDate,teacher)
                label = message(code: 'middleSchool.label')
                break
            case 'city':
                m = homeService.getStudentCountForCity(params.offset,params.max,startDate,endDate)
                label = message(code: 'city.label')
                break
        }
        def outputStream
        def titles = ["${message(code: 'home.more.number.label')}",
                "${message(code:'plan.name.label')}","${message(code:'default.count.label',args:[message(code: 'student.label')])}"]
        def datas = m.objs
        try{
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${label}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e)
                    }
                    datas.eachWithIndex {de,k->
                        def kk = k+1
                        def name = de.name
                        if(t == 'district') {
                            name = "${de.cityName}${name}"
                        }
                        def cc = de.cc?:0
                        def ts = [kk,name,cc as String]
                        ts.eachWithIndex{s,j->
                            cell(j,kk,s?:' ')
                        }
                    }
                }
            }
        }catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Student exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }
}
