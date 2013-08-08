package bm

import com.baoming.account.Student
import org.hibernate.criterion.CriteriaSpecification
import com.baoming.account.Teacher
import com.baoming.Department

class StatisticsService {

    def teacherStat(Date date,int max = 20,int offset = 0) {
        def cal = Calendar.instance
        cal.time = date
        cal.clearTime()
        def sd = cal.time
        def ed = sd + 1

        return getStudentCountInDate(sd,ed,max,offset)
    }

    def departmentStat(Date date,int max = 20,int offset = 0) {
        def cal = Calendar.instance
        cal.time = date
        cal.clearTime()
        def sd = cal.time
        def ed = sd + 1
        return getStudentCountByDepartment(sd,ed,max,offset)
    }

    /**
     * 获取在这个日期范围内的老师统计.
     *
     * @param startDate
     * @param endDate
     * @return
     */
    def getStudentCountInDate(Date startDate,Date endDate,int max = 20,int offset = 0) {
        def params = [reviewStatus:Student.ReviewStatus.PASS,max:max,offset:offset]
        def sql = "select a,"
        sql += "(select count(b.id) from a.students b where a=b.teacher and b.reviewStatus=:reviewStatus "
        if(startDate) {
            params.startDate = startDate
            sql += " and b.reviewDate >=:startDate"
        }
        if(endDate) {
            params.endDate = endDate
            sql += " and b.reviewDate <:endDate"
        }
        sql += "), "
        sql += "(select count(b.id) from a.students b where a=b.teacher and b.reviewStatus=:reviewStatus) as ccc "
        sql += "from Teacher a order by ccc desc "
        Teacher.executeQuery(sql,params)
    }

    /**
     * 获取老师统计.
     * @param startDate
     * @param endDate
     * @return
     */
    def getStudentCount() {
        return getStudentCountInDate(null,null)
    }

    /**
     * 获取在部门学生统计.
     *
     * @param startDate
     * @param endDate
     * @return
     */
    def getStudentCountByDepartment(Date startDate,Date endDate,int max = 20,int offset = 0) {
        def params = [reviewStatus:Student.ReviewStatus.PASS,max:max,offset:offset]
        def sql = "select a.name,a.taskNumber,"
        sql +="(select count(b.id) from Student b inner join b.teacher c where c.department=a and b.reviewStatus=:reviewStatus "
        if(startDate) {
            params.startDate = startDate
            sql += " and b.reviewDate >=:startDate"
        }
        if(endDate) {
            params.endDate = endDate
            sql += " and b.reviewDate <:endDate"
        }
        sql += "),(select count(b.id) from Student b inner join b.teacher c where c.department=a and b.reviewStatus=:reviewStatus) as ccc "
        sql += " from Department a order by ccc desc "
        Department.executeQuery(sql,params)
    }

    /**
     * 获取在部门学生统计.
     *
     * @param startDate
     * @param endDate
     * @return
     */
    def getStudentCountByDepartment() {
         return getStudentCountByDepartment(null,null)
    }
}
