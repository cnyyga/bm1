package com.baoming

import com.baoming.account.Student
import com.baoming.account.User

/**
 * 学生同专业，老师关系.
 * teacher为null表示学生通过网上报名
 */
class StudentPlan {
    Date dateCreated //报名时间
    User student
    Plan plan
    static constraints = {
    }

    static mapping = {
        version(false)
    }

    static StudentPlan update(Student student,Plan plan,boolean flush=false) {
        def studentPlan = StudentPlan.findByStudent(student)
        if(!studentPlan) {
            return studentPlan
        }
        studentPlan.plan = plan
        return studentPlan.save(flush: flush)
    }

    static StudentPlan create(Student student,Plan plan,boolean flush=false){
        new StudentPlan(student: student, plan: plan).save(flush: flush, insert: true)
    }

    static boolean remove(Student student,Plan plan, boolean flush = false) {
        StudentPlan instance = StudentPlan.findByStudentAndPlan(student, plan)
        if (!instance) {
            return false
        }

        instance.delete(flush: flush)
        true
    }

    static void removeAll(Student student) {
        executeUpdate 'DELETE FROM StudentPlan WHERE student=:student', [student: student]
    }

    static void removeAll(Plan plan) {
        executeUpdate 'DELETE FROM StudentPlan WHERE plan=:plan', [plan: plan]
    }

}
