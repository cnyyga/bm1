package com.baoming.account

import com.baoming.Plan
import org.springframework.dao.DataIntegrityViolationException
import com.baoming.Province
import com.baoming.City
import com.baoming.District
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.apache.commons.io.FileUtils
import org.apache.commons.io.IOUtils
import grails.plugin.jxl.builder.ExcelBuilder
import com.baoming.MiddleSchool

class StudentController {

    def userService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {

        def userId = springSecurityService.authentication.principal?.id
        params.max = Math.min(max ?: 10, 100)
        def map = userService.getStudents(userId as Long,params)
        def teachers = Teacher.findAllByEnabled(Boolean.TRUE)
        [studentInstanceList: map?.students, studentInstanceTotal: map?.total,teachers:teachers]
    }

    def createNew(Long id) {
        def studentInstance
        if(id) {
            def userId = springSecurityService.authentication.principal?.id

            if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
                studentInstance = Student.findByIdAndTeacher(id,Teacher.get(userId))
            }else{
                studentInstance = Student.get(id)
            }
            if (!studentInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
                redirect(action: "list")
                return
            }
        }else{
            studentInstance = new Student(params)
        }

        [studentInstance: studentInstance]
    }

    def saveNew(Long id) {
        def planIds = params.list('planId')

        def msg = ""
        if(!params.name) {
            msg += "姓名不能为空,"
        }
        if(!params.code) {
            msg += "考生号不能为空,"
        }
        if(!params.number) {
            msg += "身份证号不能为空,"
        }
        if(!params.provinceId || !params.cityId || !params.districtId){
            msg += "学籍所在地不能为空,"
        }
        if(!params.score || !params.int('score')) {
            msg += "高考成绩请输入整数,"
        }
        if(!planIds || planIds.empty){
            msg += "请选择专业,"
        }
        def file1 = request.getFile("admissionTicketPicInp")
        if(!params.admissionTicketPic &&  (!file1 || file1.empty)) {
            msg += "准考证照片不能为空,"
        }


        def studentInstance
        def teacher
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId as Long)
        }

        if(id) {
            if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
                studentInstance = Student.findByIdAndTeacher(id,teacher)
            }else{
                studentInstance = Student.get(id)
            }

            if (!studentInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
                redirect(action: "list")
                return
            }
        }else{
            studentInstance = new Student()
        }
        studentInstance.properties = params

        if(msg) {
            flash.message = msg
            render(view: 'createNew', model: [studentInstance: studentInstance,planIds:planIds])
            return
        }
        def scoreStr = ''
        planIds.each {p->
            def plan = Plan.get(p)
            def planScore = plan?.score?:0
            if(params.int('score') < planScore) {
                scoreStr += plan.name + ' '
            }
        }
        if(scoreStr) {
            flash.message = "高考分数未达到填报专业【${scoreStr}】分数要求，添加失败。 "
            render(view: 'createNew', model: [studentInstance: studentInstance,planIds:planIds])
            return
        }

        if(file1 &&  !file1.empty) {
            def cal = Calendar.instance
            def fileName1 = file1.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file1.transferTo(f1)
            studentInstance.admissionTicketPic = storeName1
        }

        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            //teacher = Teacher.get(userId as Long)
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }
            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT){
                studentInstance.reviewDate = new Date()
                studentInstance.reviewPerson = User.get(userId as Long)
            }
        }
        studentInstance.teacher = teacher


        studentInstance.province = Province.findByCode(params.provinceId)
        studentInstance.city = City.findByCode(params.cityId)
        studentInstance.district = District.findByCode(params.districtId)
        def u
        if(studentInstance.id) {
            u = userService.updateStudent(studentInstance,planIds)
        } else {
            studentInstance.username = UUID.randomUUID().toString()
            studentInstance.password = "1"
            u = userService.saveStudent(studentInstance,planIds)
        }

        if ( u?.status == 0){
            render(view: "createNew", model: [studentInstance: studentInstance,planIds:planIds])
            return
        }

        flash.message = id?message(code: 'student.updated.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.name]):message(code: 'default.created.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.id])
        redirect(action: "show", id: studentInstance.id)

    }

    def create() {
        def studentInstance = new Student(params)
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            studentInstance.teacher = Teacher.get(userId as Long)
        }
        def teachers = Teacher.findAllByEnabled(Boolean.TRUE)
        [studentInstance: studentInstance,teachers:teachers]
    }

    def save() {
        def userId = springSecurityService.authentication.principal?.id
        def planIds = params.list('planId')
        def studentInstance = new Student(params)
        studentInstance.birthday=params.date("birthdayDate",'yyyy-MM-dd')
        def py = params.payment as Payment
        py.date = params.date("paymentDate",'yyyy-MM-dd')
        studentInstance.payment=py

        def file = request.getFile("docPic")
        if (file && !file.empty) {
            def fileName = file.originalFilename
            def suffix = fileName.substring(fileName.lastIndexOf('.'))
            def storeName = studentInstance.number + suffix
            def url = grailsApplication.config.baoming.image.storage.path
            def storageFilePath = url +'/'+storeName
            def f = new File(storageFilePath)
            if(!f.exists()) {
                FileUtils.forceMkdir(f)
            }
            file.transferTo(f)
            studentInstance.payment.docPic = storeName
            studentInstance.payment.docDate = new Date()
        }
        def file1 = request.getFile("admissionTicketPicInp")
        if (file1 && !file1.empty) {
            def cal = Calendar.instance
            def fileName1 = file1.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${cal.time}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file1.transferTo(f1)
            studentInstance.admissionTicketPic = storeName1
        }

        def teacher
        if(params.teacherId){
            teacher = Teacher.get(params.long('teacherId'))
        }
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            if(!teacher){
                teacher = Teacher.get(userId as Long)
            }
        }else{
            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT){
                studentInstance.reviewDate = new Date()
                studentInstance.reviewPerson = User.get(userId as Long)
            }
        }

        studentInstance.teacher = teacher

        def teachers = Teacher.findAllByEnabled(Boolean.TRUE)
        if(!planIds || planIds.empty){
            flash.message = "请选择专业"
            render(view: 'create', model: [studentInstance: studentInstance,planIds:planIds,teachers:teachers])
            return
        }

        studentInstance.province = Province.findByCode(params.provinceId)
        studentInstance.city = City.findByCode(params.cityId)
        studentInstance.district = District.findByCode(params.districtId)
        studentInstance.middleSchool = MiddleSchool.get(params.long('middleSchoolId'))

        def u = userService.saveStudent(studentInstance,planIds)

        if ( u.status == 0){
            render(view: "create", model: [studentInstance: studentInstance,planIds:planIds,teachers:teachers])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.id])
        redirect(action: "show", id: studentInstance.id)
    }

    def show(Long id) {
        def studentInstance
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId as Long)
            studentInstance = Student.findByIdAndTeacher(id,teacher)
        }else{
            studentInstance = Student.get(id)
        }
        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            redirect(action: "list")
            return
        }

        [studentInstance: studentInstance]
    }

    def edit(Long id) {
        def studentInstance = Student.get(id)

        if (studentInstance && SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId as Long)
            def districts = teacher?.teacherDistricts*.district
            def stuCity = studentInstance.district
            if (!districts || districts.empty || districts.count(stuCity) == 0) {
                studentInstance = null
            }
        }
        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            redirect(action: "list")
            return
        }
        def teachers = Teacher.findAllByEnabled(Boolean.TRUE)
        [studentInstance: studentInstance,teachers:teachers]
    }

    def update(Long id, Long version) {

        def studentInstance = Student.get(id)
        if (studentInstance && SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId as Long)
            def districts = teacher?.teacherDistricts*.district
            def stuCity = studentInstance.district
            if (!districts || districts.empty || districts.count(stuCity) == 0) {
                studentInstance = null
            }
        }

        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            redirect(action: "list")
            return
        }

        def planIds = params.list('planId')

        if(!planIds){
            flash.message = "请选择专业"
            render(view: 'index', model: [student: studentInstance])
            return
        }

        studentInstance.properties = params
        studentInstance.birthday=params.date("birthdayDate",'yyyy-MM-dd')
        def py = params.payment as Payment
        py.date = params.date("paymentDate",'yyyy-MM-dd')
        py.docPic = studentInstance.payment?.docPic
        py.docDate = studentInstance.payment?.docDate
        studentInstance.payment=py

        def file = request.getFile("docPic")
        if (file && !file.empty) {
            def fileName = file.originalFilename
            def suffix = fileName.substring(fileName.lastIndexOf('.'))
            def storeName = studentInstance.number + suffix
            def url = grailsApplication.config.baoming.image.storage.path
            def storageFilePath = url +'/'+storeName
            def f = new File(storageFilePath)
            if(!f.exists()) {
                FileUtils.forceMkdir(f)
            }
            file.transferTo(f)
            studentInstance.payment.docPic = storeName
            studentInstance.payment.docDate = new Date()
        }
        def file1 = request.getFile("admissionTicketPicInp")
        if (file1 && !file1.empty) {
            def fileName1 = file1.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${studentInstance.id}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file1.transferTo(f1)
            studentInstance.admissionTicketPic = storeName1
        }

        if (SpringSecurityUtils.ifNotGranted(Role.AUTHORITY_TEACHER)) {
            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT){
                def userId = springSecurityService.authentication.principal?.id
                studentInstance.reviewDate = new Date()
                studentInstance.reviewPerson = User.get(userId as Long)
            }
        }

        studentInstance.province = Province.findByCode(params.provinceId)
        studentInstance.city = City.findByCode(params.cityId)
        studentInstance.district = District.findByCode(params.districtId)
        def teacher
        if(params.teacherId){
            teacher = Teacher.get(params.long('teacherId'))
        }
        studentInstance.teacher = teacher
        studentInstance.middleSchool = MiddleSchool.get(params.long('middleSchoolId'))
        def s = userService.updateStudent(studentInstance,planIds)
        if (s.status == 0) {
            flash.message = s.msg
            render(view: 'edit', model: [student: studentInstance,planIds:planIds])
            return
        }

        /*if (!studentInstance.save(flush: true)) {
            render(view: "edit", model: [studentInstance: studentInstance])
            return
        }*/

        flash.message = message(code: 'student.updated.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.name])
        redirect(action: "show", id: studentInstance.id)
    }

    def delete(Long id) {
        def studentInstance = Student.get(id)
        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            userService.removeStudent(studentInstance)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'student.label', default: 'Student'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'student.label', default: 'Student'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }

    def delMore() {
        def ids = params.ids
        if(!ids) {
            render(([status:0] as JSON) as String )
        }
        ids = ids.tokenize(',')
        def su = 0
        def fa = 0
        ids.each{id->
            def studentInstance = Student.get(id)
            if(!studentInstance) {
                fa++
                return
            }
            try {
                userService.removeStudent(studentInstance)
                su++
            }
            catch (DataIntegrityViolationException e) {
                fa++
            }
        }
        render(([status:1,successNum:su,failureNum:fa] as JSON) as String )
    }

    def delPaymentPic(Long id){
        def studentInstance = Student.get(id)
        if (!studentInstance || !studentInstance.payment ) {
            render(([status:0] as JSON) as String)
            return
        }
        studentInstance.payment.docPic = null
        studentInstance.payment.docDate = null
        if(!studentInstance.save()){
            render(([status:0] as JSON) as String)
            return
        }
        render(([status:1] as JSON) as String)
    }

    def export() {
        def userId = springSecurityService.authentication.principal?.id
        def map = userService.getStudents(userId as Long,params)
        def f = params.f
        if(!f) {
            render(message(code: 'student.select.zd.message'))
            return
        }
        def fs = f.tokenize(',')
        def outputStream
        try {
            def list = map?.students
            def studentDatas = getStudentDatas(list,fs)
            def datas =  studentDatas.datas
            def titles = studentDatas.titles
            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'download.file.label')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                         cell(i,0,e)
                     }
                    datas.eachWithIndex {de,k->
                        def kk = k+1
                        de.eachWithIndex{s,j->
                            cell(j,kk,s?:' ')
                        }
                    }
                }
            }
            //
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Student exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }

    private getStudentDatas(def list,def fs) {
        def datas = []
        def title = []
        fs << 'dateCreated'
        list.eachWithIndex {stu,i->
            def data = []
            stu = stu as Student
            if(fs.count('name') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.name.label')
                }
                data << stu.name
            }
            if(fs.count('gender') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.gender.label')
                }
                data << stu.gender?.label?:''
            }
            if(fs.count('code') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.code.label')
                }
                data << stu.code?:''
            }
            if(fs.count('admissionTicketNumber') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.admissionTicketNumber.label')
                }
                data << stu.admissionTicketNumber?:''
            }
            if(fs.count('number') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.number.label')
                }
                data << stu.number?:''
            }
            if(fs.count('birthday') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.birthday.label')
                }
                data << stu.birthday?.format('yyyy-MM-dd')?:''
            }
            if(fs.count('politicalStatus') > 0 ){
                if(i ==0 ){
                    title << message(code: 'politicalStatus.label')
                }
                data << stu.politicalStatus?.name?:''
            }
            if(fs.count('nation') > 0 ){
                if(i ==0 ){
                    title << message(code: 'nation.label')
                }
                data << stu.nation?.name?:''
            }
            if(fs.count('address') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.address.label')
                }
                data << stu.address?:''
            }
            if(fs.count('postcode') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.postcode.label')
                }
                data << stu.postcode?:''
            }
            if(fs.count('phone') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.phone.label')
                }
                data << stu.phone?:''
            }
            if(fs.count('tel') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.tel.label')
                }
                data << stu.tel?:''
            }
            if(fs.count('email') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.email.label')
                }
                data << stu.email
            }
            if(fs.count('qq') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.qq.label')
                }
                data << stu.qq?:''
            }
            if(fs.count('district') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.district.label')
                }
                data << "${stu.city?.name}${stu.district?.name}"
            }
            if(fs.count('middleSchool') > 0 ){
                if(i ==0 ){
                    title << message(code: 'middleSchool.label')
                }
                data << stu.middleSchool?.name?:''
            }
            if(fs.count('paymentType') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.payment.type.label')
                }
                data << stu.payment?.type?.label?:''
            }
            if(fs.count('paymentName') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.payment.name.label')
                }
                data << stu.payment?.name?:''
            }
            if(fs.count('paymentAccount') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.payment.account.label')
                }
                data << stu.payment?.account ?:''
            }
            if(fs.count('paymentAmount') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.payment.amount.label')
                }
                data << stu.payment?.amount?:''
            }
            if(fs.count('paymentDate') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.payment.date.label')
                }
                data << stu.payment?.date?.format('yyyy-MM-dd') ?:''
            }
            if(fs.count('studentType') > 0 ){
                if(i ==0 ){
                    title << message(code: 'studentType.label')
                }
                data << stu.studentType?.name  ?:''
            }
            if(fs.count('score') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.score.label')
                }
                data << stu.score  ?:''
            }
            if(fs.count('level') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.level.label')
                }
                data << stu.level ?:''
            }
            if(fs.count('artsScore') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.artsScore.label')
                }
                data << stu.artsScore  ?:''
            }
            if(fs.count('sportsScore') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.sportsScore.label')
                }
                data << stu.sportsScore  ?:''
            }
            if(fs.count('plans') > 0 ){
                if(i ==0 ){
                    title << message(code: 'student.plans.label')
                }
                data << stu.plans*.name?.join(',')   ?:''
            }
            if(fs.count('recommend') > 0)  {
                if(i ==0 ){
                    title << message(code: 'student.recommend.teacher.label')
                }
                data << stu.teacher?.name
            }
            if(fs.count('dateCreated') > 0)  {
                if(i ==0 ){
                    title << message(code: 'student.created.label')
                }
                data << stu.dateCreated?.format('yyyy-MM-dd HH:mm:ss')
            }

            datas << data
        }
        return [titles:title,datas:datas]
    }

    def audit(Long id) {
        def studentInstance = Student.get(id)
        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            redirect(action: "list")
            return
        }
        studentInstance.properties = params
        if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT){
            def userId = springSecurityService.authentication.principal?.id
            studentInstance.reviewDate = new Date()
            studentInstance.reviewPerson = User.get(userId as Long)
        }
        if(!studentInstance.save()) {
            flash.message = message(code: 'student.updated.audit.failure.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.name])
            redirect(action: "show", id: studentInstance.id,params: [t:'au'])
            return
        }
        flash.message = message(code: 'student.updated.audit.message', args: [message(code: 'student.label', default: 'Student'), studentInstance.name])
        redirect(action: "show", id: studentInstance.id)
    }
}
