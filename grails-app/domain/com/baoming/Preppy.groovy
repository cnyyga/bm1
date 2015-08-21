package com.baoming

import com.baoming.account.Teacher
import com.baoming.account.User

/**
 * 预科生.
 */
class Preppy {

    String name    //姓名
    String number //身份证号
    Date birthday //出生日期
    User.Gender gender //性别
    District district//考生户口所在地区
    City city //市
    Province province//省
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
    PreppyPlan preppyPlan//所属科目组
    Plan plan //申请就读专业
    BigDecimal deposit//缴纳保证金
    String phone//学生手机
    String parentPhone//家长手机
    String address//家庭住址

    ReviewStatus reviewStatus
    Date reviewDate
    User reviewPerson
    StudentCateories studentCateories   //考生类型
    String protocolCode //协议号
    //////old/////////////
    Family family = Family.OTHER //户籍类型
    Family studentFamily = Family.OTHER //学籍类型
    CollegeType collegeType =  CollegeType.HIGH //高考类型
    Status status = Status.DROP //上学状态
    String qq
    String tel
    Teacher teacher  //推荐老师
    ///////
    String hkbPath //户口本首页
    String hkbksyPath//户口本考生页
    String cardPhotoPath//身份证照片
    String byzsPath//高中（中职）毕业证书
    String xjzmPath//学籍证明（本省在校中职生）

    String remark

    Date dateCreated
    Date lastUpdated

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
        JIANGSU(1,'江苏省'),
        OTHER(2,'外省')

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
        JSPG(2,'参加江苏省普高注册入学'),
        JSZZ(3,'参加江苏省中职注册入学') ,
        GJSZZ(4,'挂江苏中职学籍'),
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
        SZ (3,'外省')

        Integer id
        String label

        StudentCateories(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
