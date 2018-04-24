package com.baoming

import com.baoming.account.Student
import com.baoming.account.Teacher
import com.baoming.account.User
import com.bm.TopupStatus

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

    String phone //联系电话
    String qq //qq号

    String secondaryPlan//中专专业
    MediumPlan mediumPlan //原中专科目组
    Plan plan //大学拟就读专业
    Teacher teacher  //推荐老师
    String description //备注
    String voucherPath //预交费凭证
    String cardNoPath //身份证
    String admissionPath //准考证
    String agreementPath //协议

    DepositType depositType//缴费方式
    BigDecimal deposit //缴费金额

    Student.Admission admission = Student.Admission.NO   //录取状态
    Student.Registration registration = Student.Registration.NO //报到 状态
    Student.ReviewStatus reviewStatus =Student.ReviewStatus.NO_AUDIT//审核

    User reviewPerson  //审核人
    Date reviewDate //审核日期
    TopupStatus topupStatus = TopupStatus.NO//是否有专接本意向
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
        cardNoPath(nullable: true)
        admissionPath(nullable: true)
        agreementPath(nullable: true)
        reviewPerson(nullable: true)
        secondaryPlan(nullable: true)
        qq(nullable: true)
        phone(nullable: true)
    }


    enum DepositType{
        //江苏普高、江苏中职、外省
        NONE(1,'未缴费'),
        BZR (2,'交中学班主任'),
        ZB (3,'在招办交费'),
        YHZZ (4,'银行转账'),
        ZSLS (5,'招生老师收费');

        Integer id
        String label

        DepositType(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
