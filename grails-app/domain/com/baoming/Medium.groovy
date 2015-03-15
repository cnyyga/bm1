package com.baoming

import com.baoming.account.Student
import com.baoming.account.Teacher
import com.baoming.account.User

class Medium {

    String name  //中职生姓名
    String code //考生号
    String number //身份证号
    User.Gender gender //性别
    District district//考生户口所在地区
    City city //市
    Province province//省

    District studentDistrict//学籍学所在地区
    City studentCity //市
    Province studentProvince//省

    MediumPlan mediumPlan //原中专科目组
    Plan plan //大学拟就读专业
    Teacher teacher  //推荐老师
    String description //备注
    String voucherPath //凭证

    Student.Admission admission = Student.Admission.NO   //录取状态
    Student.Registration registration = Student.Registration.NO //报到 状态
    Student.ReviewStatus reviewStatus =Student.ReviewStatus.NO_AUDIT//审核

    User reviewPerson  //审核人
    Date reviewDate //审核日期

    Date dateCreated
    Date lastUpdated
    static constraints = {
        name()
        code()
        number()
        gender()
        mediumPlan()
        plan()
        teacher()
        voucherPath()
        admission()
        registration()
        reviewStatus()
        reviewDate(nullable: true)
        description()
        reviewPerson(nullable: true)
    }

}
