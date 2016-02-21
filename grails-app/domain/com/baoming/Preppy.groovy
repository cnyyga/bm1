package com.baoming

import com.baoming.account.Teacher
import com.baoming.account.User

/**
 * 预科生.
 */
class Preppy {

    String name    //姓名 -2016
    String number //身份证号 -2016
    Date birthday //出生日期 -2016
    User.Gender gender //性别 -2016
    District district//考生户口所在地区 -2016
    Nation nation//民族 -2016
    City city //市 -2016
    Province province//省 -2016
    District studentDistrict//学籍学所在地区
    City studentCity //市
    Province studentProvince//省
    String school //学籍学所在地区学校

    Type type//考生类别

    String academicYear //学业水平测试
    String academicScore//学业水平测试成绩 ,eg:物理,化学,生物,地理,历史,政治
    Skill skill //技术

    SchoolType schoolType //学校类别
    String middlePlan //原就读专业
    PreppyPlan preppyPlan//所属科目组  -2016
    Plan plan //申请就读专业 -2016
    BigDecimal deposit//缴纳保证金-2016
    String phone//学生手机 -2016
    String parentPhone//家长手机 -2016
    String address//家庭住址 -2016

    ReviewStatus reviewStatus // -2016
    Date reviewDate
    User reviewPerson
    StudentCateories studentCateories   //考生类型 -2016
    String protocolCode //协议号
    CollegeSignUp collegeSignUp//高考报名地  -2016
    //////old/////////////
    Family family = Family.OTHER //户籍类型 -2016
    Family studentFamily = Family.OTHER //学籍类型
    CollegeType collegeType =  CollegeType.HIGH //高考类型
    Status status = Status.DROP //上学状态
    String qq //-2016
    String tel
    Teacher teacher  //推荐老师 -2016
    ///////
    String hkbPath //户口本首页
    String hkbksyPath//户口本考生页
    String cardPhotoPath//身份证照片
    String byzsPath//高中（中职）毕业证书
    String xjzmPath//学籍证明（本省在校中职生）

    String resume
    String remark //备注1
    String remark1//备注2
    String remark2//备注3

    Date dateCreated
    Date lastUpdated //-2016

    static constraints = {
        name()
        number()
        birthday nullable: true
        gender()
        district nullable: true
        city nullable: true
        province nullable: true
        qq nullable: true
        tel nullable: true
        plan nullable: true
        teacher nullable: true
        reviewStatus nullable: true
        reviewDate nullable: true
        reviewPerson nullable: true
        studentCateories nullable: true
        studentFamily nullable: true
        collegeType nullable: true
        family(nullable: true)
        studentFamily nullable: true
        status nullable: true
        collegeType nullable: true
        protocolCode nullable: true
        preppyPlan nullable: true
        hkbPath nullable: true
        hkbksyPath nullable: true
        cardPhotoPath nullable: true
        byzsPath nullable: true
        xjzmPath nullable: true
        remark nullable: true
        remark1 nullable: true
        remark2 nullable: true
        nation nullable: true
        collegeSignUp nullable: true
        resume nullable: true,maxSize: 1024
    }

    static mapping = {
        remark sqlType: 'text'
    }
    enum CollegeType {
        HIGH(1,'普高'),
        VOCATION (2,'中职')

        Integer id
        String label

        CollegeType(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Skill {
        YES(0,'合格'),
        NO (1,'不合格')

        Integer id
        String label

        Skill(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Type {
        FRESH(1,'应届生'),
        PREVIONS  (2,'往届生 ') ,
        DROPOUT (3,'肄业生')

        Integer id
        String label

        Type(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum SchoolType {
        SECONDARY(1,'中职生'),
        INDUSTRIAL(2,'技校生 ') ,
        HIGH(3,' 高中生')

        Integer id
        String label

        SchoolType(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Family {
        JIANGSU(1,'江苏户籍'),
        OTHER(2,'非江苏户籍')

        Integer id
        String label

        Family(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum Status {
        GRADUATE(1,'已毕业'),
        STUDENT(2,'在读'),
        DROP(3,'弃学')

        Integer id
        String label

        Status(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum ReviewStatus{
        NO_AUDIT(1,'未审核'),
        JSPG(2,'江苏普高'),
        JSZZ(3,'江苏中职') ,
        GJSZZ(4,'挂学籍'),
        NO_PASS(5,'审核未通过')

        Integer id
        String label

        ReviewStatus(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
    enum StudentCateories {
        //江苏普高、江苏中职、外省
        SG(1,'江苏普高'),
        WG (2,'江苏中职'),
        SZ (3,'外省'),
        SC4 (4,'中职在校生'),
        SC5 (5,'普通高中在校生'),
        SC6 (6,'中职毕业生未曾被普通高校录取'),
        SC7 (7,'中职毕业生已经被普通高校录取'),
        SC8 (8,'普通高中毕业生未曾被普通高校录取'),
        SC9 (9,'普通高中毕业生已经被普通高校录取'),
        SC10 (10,'曾经在江苏高中或中职读书'),
        SC11 (11,'一直在其他省份高中或中职读书')

        public static SC_SL = [SC4,SC5,SC6,SC7,SC8,SC9]
        public static SC_SW = [SC10,SC11]

        Integer id
        String label

        StudentCateories(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

    enum CollegeSignUp{
        //江苏普高、江苏中职、外省
        SG(1,'钟山学院'),
        WG (2,'原籍、原校');

        Integer id
        String label

        CollegeSignUp(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
