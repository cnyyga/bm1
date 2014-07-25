package bm

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.baoming.account.Role
import com.baoming.account.Student
import com.baoming.account.Teacher
import com.baoming.City
import com.baoming.account.Student.ReviewStatus
import com.baoming.account.User
import com.baoming.StudentPlan
import groovy.sql.Sql
import com.baoming.District
import com.baoming.Plan
import com.baoming.MiddleSchool

class HomeService {

    def dataSource

    def getStudentCount(Date startDate = null,Date endDate = null,Teacher teacher = null,Student.ReviewStatus reviewStatus = null){
         return Student.createCriteria().count{
             if(startDate)
                 ge('dateCreated',startDate)
             if(endDate)
                 lt('dateCreated',endDate)
             if(teacher) {
                 eq('teacher',teacher)
             }
             eq("regType", 1 as Short)

             if(reviewStatus)
                 eq('reviewStatus',reviewStatus)
         }
    }

    def getStudentCountForTeacher(int offset=0,int max=10,Date startDate = null,Date endDate = null) {
         def r = getSutdentsForTeacher(offset,max,startDate,endDate)
        [objs:r,total:Teacher.count()]
    }

    def getSutdentsForTeacher(int offset=0,int max=10,Date startDate = null,Date endDate = null){
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            return
        }

        def params = [:]

        def str = "select u.id,u.name,(" +
                "select count(distinct a.id) from user a " +
                "where a.class='com.baoming.account.Student' and (a.teacher_id=u.id " +
                ") and a.reg_type = 1 and a.review_status=2 "
        if(startDate)  {
            str += " and a.date_created>=:startDate"
            params.startDate = startDate
        }
        if(endDate) {
            str += " and a.date_created <:endDate"
            params.endDate = endDate
        }
        str += ") as cc from user u where u.class='com.baoming.account.Teacher' order by cc desc ; "
        def sql = new Sql(dataSource)
        return sql.rows(str,params,offset,max)

    }

    def getStudentCountForDistrict(int offset,int max,Date startDate = null,Date endDate = null,Teacher teacher=null) {
        def r = getSutdentsForCity(offset,max,startDate,endDate,teacher)
        [objs:r,total: District.count()]
    }

    def getSutdentsForCity(int offset,int max,Date startDate = null,Date endDate = null,Teacher teacher=null){
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            //return
        }
        def params = [:]
        def sql = "select a.code,a.name,c.code as cityCode,c.name as cityName,c.province_id as provinceCode," +
                "(select count(b.id) from user b where b.class='com.baoming.account.Student'  and b.reg_type = 1  and b.review_status=2 and b.district_id=a.code "
        if(teacher) {
            sql += " and ( b.teacher_id=:teacherId) "
            params.teacherId=teacher.id
        }
        if(startDate)  {
            sql += " and b.date_created>=:startDate"
            params.startDate = startDate
        }
        if(endDate) {
            sql += " and b.date_created <:endDate"
            params.endDate = endDate
        }
        sql +=" ) as cc from district a"
        sql += " inner join city c on a.city_id=c.code "
        sql += " order by cc desc"
        def db = new Sql(dataSource)
        return db.rows(sql,params,offset,max)
    }

    def getSutdentsForCity(Date startDate = null,Date endDate = null,Teacher teacher=null){
        //if(!teacher) {
            return getSutdentsForCity(0,10,startDate,endDate,teacher)
       //}
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            //return
        }
        def r =  Student.createCriteria().list {
            if(teacher){
                eq('teacher',teacher)
            }
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            projections {
                groupProperty('district')
                count('id','cc')
                order('cc','desc')
            }
            maxResults(10)
        }
        return r?r?.collect {
            try {
                return [id:it[0].code,name:it[0].name,cc: it[1]]
            } catch (Exception e) {
                return [id:null,name:'Other',cc: it[1]]
            }
        }:[]
    }

    def getStudentCountForPlan(int offset,int max ,Date startDate = null,Date endDate = null,Teacher teacher=null) {
         def r = getStudentsForPlan(offset,max,startDate,endDate,teacher)
        [objs: r,total: Plan.count()]
    }

    def getStudentsForPlan(int offset,int max ,Date startDate = null,Date endDate = null,Teacher teacher=null){
        def params = [:]
        def sql = "select a.id,a.name," +
                "(select count(b.student_id) from student_plan b inner join user u on b.student_id=u.id  where  b.plan_id=a.id and u.class='com.baoming.account.Student' "
        if(teacher) {
            sql += " and ( u.teacher_id=:teacherId )"
            params.teacherId=teacher.id
        }
        if(startDate)  {
            sql += " and b.date_created>=:startDate"
            params.startDate = startDate
        }
        if(endDate) {
            sql += " and b.date_created <:endDate"
            params.endDate = endDate
        }
        sql +=" and u.reg_type = 1 and u.review_status=2 ) as cc from plan a"
        sql += " order by cc desc"
        def db = new Sql(dataSource)
        return db.rows(sql,params,offset,max)
    }

    def getStudentsForPlan(Date startDate = null,Date endDate = null,Teacher teacher=null){
        //if(!teacher){
            return getStudentsForPlan(0,10,startDate,endDate,teacher)
        //}
        def sps = StudentPlan.createCriteria().list {
             if(teacher){
                 student{
                     eq('teacher',teacher)
                     eq("regType",1 as Short)
                     eq("reviewStatus",ReviewStatus.PASS)
                 }
             }
             if(startDate)
                 ge('dateCreated',startDate)
             if(endDate)
                 lt('dateCreated',endDate)
             projections {
                 groupProperty('plan')
                 count('student','cc')
                 order('cc','desc')
             }
             maxResults 10
             firstResult 0
         }
        return sps.collect{
            [id: it[0].id,name: it[0].name,total: it[1]]
        }
    }

    def getStudentsForMiddleSchool(int offset,int max,Date startDate = null,Date endDate = null, Teacher teacher=null) {
        def params = [:]
          def sql = "select a.id,a.name," +
                  "(select count(u.id) from user u where u.class='com.baoming.account.Student' and u.middle_school_id = a.id"
        if(startDate)  {
            sql += " and u.date_created>=:startDate"
            params.startDate = startDate
        }
        if(endDate) {
            sql += " and u.date_created <:endDate"
            params.endDate = endDate
        }
            sql += ") as cc" +
                  " from middle_school a" +
                  " order by cc desc;"
        def db = new Sql(dataSource)
        return db.rows(sql,params,offset,max)
    }

    def getStudentCountForMiddleSchool(int offset,int max,Date startDate = null,Date endDate = null, Teacher teacher=null) {
        def r = getStudentsForMiddleSchool(offset,max,startDate,endDate,teacher)
        [objs: r,total: MiddleSchool.count()]
    }

    def getStudentCountForCity1(Date startDate = null,Date endDate = null) {
        return getStudentCountForCity(0,10,startDate,endDate).objs
    }

    def getStudentCountForCity(int offset,int max,Date startDate = null,Date endDate = null) {
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            return
        }
        def params = [:]
        def sql = "select a.code as id,a.name,a.province_id as provinceId," +
                "(select count(u.id) from user u where u.class='com.baoming.account.Student'  and u.reg_type = 1 and u.review_status=2  and u.city_id = a.code"
        if(startDate)  {
            sql += " and u.date_created>=:startDate"
            params.startDate = startDate
        }
        if(endDate) {
            sql += " and u.date_created <:endDate"
            params.endDate = endDate
        }
        sql += ") as cc" +
                " from city a" +
                " order by cc desc;"
        def db = new Sql(dataSource)
        def r=  db.rows(sql,params,offset,max)
        [objs: r,total: City.count]
    }

    /**
     * 图表每年的学生数.
     */
    def getStudentNumberChartOfYear(Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {
        def cal = Calendar.instance
        def endYear = cal.get(Calendar.YEAR)
        def startYear = endYear - 10
        def sts = Student.createCriteria().list {
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            projections {
                property('dateCreated')
            }
        }
        sts = sts.groupBy {ele->
            ele.format('yyyy')
        }
        def list = []
        (startYear..endYear).each {ele->
            def key = ele as String
            def y = Date.parse('yyyy',key)
            list << [y.time,(sts && sts[key])?sts[key].size():0]
        }
        return list
    }

    def getStudentNumberChartOfGender(Date startDate = null,Date endDate = null, Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {
        def sts = []
        if(teacher){
            sts = Student.createCriteria().list {
                if (startDate)
                    ge('dateCreated', startDate)
                if (endDate)
                    lt('dateCreated', endDate)
                or {
                    eq('teacher', teacher)
                }
                if (city)
                    eq('city', city)
                if (reviewStatus) {
                    eq('reviewStatus', reviewStatus)
                }
                projections {
                    groupProperty('gender')
                    count('id')
                }
            }
        }else{
            sts = Student.createCriteria().list {
                if(startDate)
                    ge('dateCreated',startDate)
                if(endDate)
                    lt('dateCreated',endDate)
                if(city)
                    eq('city',city)
                if(reviewStatus){
                    eq('reviewStatus',reviewStatus)
                }
                projections {
                    groupProperty('gender')
                    count('id')
                }
            }
        }

        def list = []
        def rss = User.Gender.values()
        rss.collect {ele->
            def num = 0
            sts.each {s->
                if(s[0] == ele){
                    num = s[1]
                    return
                }
            }
            list << [label:ele.label,data: num]
        }

        return list
    }

    def getStudentNumberChartOfCity(Date startDate = null,Date endDate = null, Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {

        def sts = Student.createCriteria().list {
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            projections {
                groupProperty('city')
                count('id','cc')
                order('cc','desc')
            }
        }

        def list = []
        int mx = 10
        if(sts.size() > mx) {
            def others = sts[mx..<sts.size()]
            def othersC = others.sum {it[1]}
            sts = sts[0..<mx]
            list << [label:'其它地区',data: othersC]
        }
        sts.each {ele->
            def name = ele[0]?ele[0].name:'未选择地区'
            def num = ele[1]
            list << [label:name,data: num]
        }
        return list
    }

    def getStudentNumberChartOfMiddleSchool(Date startDate = null,Date endDate = null, Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {
        def sts = Student.createCriteria().list {
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            projections {
                groupProperty('middleSchool')
                count('id')
            }
        }
        def list = []
        sts.each {ele->
            def name = ele[0]?ele[0].name:'other'
            def num = ele[1]
            list << [label:name,data: num]
        }
        return list
    }

    def getStudentNumberChartOfReviewStatus(Date startDate = null,Date endDate = null, Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {
        def sts = Student.createCriteria().list {
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            projections {
                groupProperty('reviewStatus')
                count('id')
            }
        }

        def list = []
        def rss = ReviewStatus.values()
        rss.collect {ele->
            def num = 0
            sts.each {s->
               if(s[0] == ele){
                   num = s[1]
                   return
               }
            }
            list << [label:ele.label,data: num]
        }

        return list
    }

    def messageSource

    /**
     * 老师招生和自助报名数.
     * @param startDate
     * @param endDate
     * @param teacher
     * @param city
     * @param reviewStatus
     * @return
     */
    def getStudentNumberChartOfTeacher(Date startDate = null,Date endDate = null, Teacher teacher=null,City city = null,ReviewStatus reviewStatus = null) {
        def sts = Student.createCriteria().count {
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            isNotNull('teacher')
        }


        def sts1 = Student.createCriteria().count {
            if(startDate)
                ge('dateCreated',startDate)
            if(endDate)
                lt('dateCreated',endDate)
            if(teacher){
                eq('teacher',teacher)
            }
            if(city)
                eq('city',city)
            if(reviewStatus){
                eq('reviewStatus',reviewStatus)
            }
            isNull('teacher')
        }


        return [[label:messageSource.getMessage('home.teacher.add.label',null,null),data:sts],[label:messageSource.getMessage('home.auto.add.label',null,null),data: sts1]]
    }

    def teachersSt() {

    }
}
