package com.baoming.account

import com.baoming.PoliticalStatus
import com.baoming.Nation
import com.baoming.StudentType
import com.baoming.GraduationType
import com.baoming.MiddleSchool
import com.baoming.ForeignLanguage
import com.baoming.PolicyCode
import com.baoming.Unit
import com.baoming.District
import com.baoming.ExaminationType
import com.baoming.Batch
import com.baoming.BranchCode
import com.baoming.ArchivesUnit
import com.baoming.PlanType
import com.baoming.VoluntaryCharacter
import com.baoming.ArchivesRevertReason
import com.baoming.MatriculateType
import com.baoming.City
import com.baoming.Province
import com.baoming.StudentPlan
import com.baoming.Plan

//考生投档单表
class Student extends User{

    String name
    User.Gender gender //性别
    String code //考生号
    String admissionTicketNumber //准考证号
    Date birthday //出生年月
    String number //身份证号
    PoliticalStatus politicalStatus //政治面貌
    Nation nation //民族
    String address //家庭地址
    String phone //手机号码
    String postcode //    邮政编码
    String tel //联系电话
    String email //邮件地址
    String qq //qq号
    MiddleSchool middleSchool //毕业中学
    District district//考生户口所在地区
    City city //市
    Province province//省
    String description

    Date dateCreated
    Date lastUpdated

    Integer score //高考成绩
    String level //学业水平测试等级
    Integer artsScore //美术省统考成绩
    Integer sportsScore//体育省统考成绩

    String admissionTicketPic //照片

    Teacher teacher

    Payment payment

    StudentType studentType //  考生类别

    ReviewStatus reviewStatus = ReviewStatus.NO_AUDIT //付费状态
    User reviewPerson  //审核人
    Date reviewDate //审核日期
    String reviewDescription //备注

    Admission admission = Admission.NO   //录取状态
    Registration registration = Registration.NO //报到 状态
    Short regType = 0 //0表示前台学生注册，1=表示老师添加

    static hasMany = [studentPlans: StudentPlan]

    static constraints = {
        name(blank: false, maxSize: 32)
        gender(maxSize: 1, nullable: true)
        code(maxSize: 64, nullable: true)
        admissionTicketNumber(nullable: true, maxSize: 64)
        birthday blank: false , nullable: true
        number blank: false, maxSize: 18
        politicalStatus nullable: true
        nation nullable: true
        address maxSize: 255  , nullable: true
        postcode nullable: true, maxSize: 6
        tel blank: false, maxSize: 32, nullable: true
        email nullable: true, maxSize: 64
        qq nullable: true, maxSize: 16
        middleSchool nullable: true
        district blank: false, nullable: true
        city blank: false  , nullable: true
        province blank: false , nullable: true
        description nullable: true, maxSize: 1024
        phone nullable: true ,maxSize: 16
        score( nullable: true)
        level(nullable: true,maxSize: 32)
        artsScore(nullable: true)
        sportsScore(nullable: true)
        teacher nullable: true
        payment nullable: true
        studentType nullable: true
        reviewPerson nullable: true
        reviewDate(nullable: true)
        reviewDescription nullable: true
        reviewStatus nullable: true
        admissionTicketPic nullable: true
    }

    static mapping = {
        number(index: 'user_number_Idx')
    }

    static embedded = ['payment']

    Set<Plan> getPlans() {
        StudentPlan.findAllByStudent(this)?.collect {it.plan}
    }

    enum ReviewStatus{
        NO_AUDIT(1,'未审核'),
        PASS(2,'审核通过'),
        NO_PASS(3,'审核未通过')

        Integer id
        String label

        ReviewStatus(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Admission {
        OK(1,'录取'),
        NO (2,'未录取')

        Integer id
        String label

        Admission(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Registration {
        OK(1,'报到'),
        NO (2,'未报到')

        Integer id
        String label

        Registration(Integer id,String label){
            this.id = id
            this.label = label
        }
    }


/*
GraduationType graduationType //毕业类别代码
ForeignLanguage foreignLanguage  //外语语种
String examinationLevel   // A，B，C，D等
String registrationUnit //报名单位
PolicyCode policyCode //政策代码,考生特征(按位提取)
Unit unit //系统单位代码
String  examineNumber//会考考号
String specialty //特长
String rewardPunishment  //奖励或处分
String oral //外语口试
String opinionPolitics// 政审意见
ExaminationType examinationType //考试类型
String recipients //收件人
String rollCode //应试卷种代码
String foreignListening //外语听力
Batch batch //批次代码
BranchCode branchCode //科类代码
ArchivesUnit archivesUnit //投档单位代码
PlanType planType //计划性质
BigDecimal score //考生成绩
BigDecimal characteristicsScore // 特征成绩
BigDecimal archiversScore //投挡成绩
BigDecimal attendsScore //照顾分
BigDecimal collegesScore //院校导入成绩
BigDecimal professionalArchivesScore //专业投档基准成绩
BigDecimal attachArchivesScore //专业投档附加成绩
VoluntaryCharacter voluntaryCharacter //投档志愿
ArchivesUnit archivesUnit1 //  当前投档单位代码
String prepareSpecialty // 预投专业
String enterSpecialty //录取专业
ArchivesRevertReason archivesRevertReason //退挡原因
String description //备注
Boolean specialtyQualified   //专业合格
Boolean physical      //体检合格
MatriculateType matriculateType //录取方式
String status //考生状态
String lock //锁定标志
VoluntaryCharacter voluntaryCharacter1 //志愿特征
Boolean adjust //专业志愿调剂
Boolean directionalAdjust//是否服从定向调剂
Boolean specialtyAdjust//专业调剂服从*/

}

class Payment {

    Type type
    String name
    String account
    BigDecimal amount
    Date date
    String docPic //缴费单据图片地址
    Date docDate //单据上传时间

    static constraints = {
        type nullable: true
        name nullable: true
        account(nullable: true)
        amount nullable: true
        date nullable: true
        docPic nullable: true
        docDate nullable: true
    }
    enum Type{
        CASH(1,'现金付款'),
        BANK(2,'银行汇款'),
        NET(3,'网上转账'),
        ONLINE(4,'POS机缴费'),
        ADMISSIONTICKER(5,'准考证')

        Integer id
        String label

        Type(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}

