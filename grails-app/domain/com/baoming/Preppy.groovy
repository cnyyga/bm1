package com.baoming

import com.baoming.account.Teacher
import com.baoming.account.User

/**
 * 预科生.
 */
class Preppy {

    String name
    String number //身份证号
    User.Gender gender //性别
    District district//考生户口所在地区
    City city //市
    Province province//省
    Family family //户籍类型
    CollegeType collegeType  //高考类型
    Status status //上学状态
    String middlePlan //中学 专业
    Plan plan //大学拟就读专业
    String phone
    String qq
    String tel
    Teacher teacher  //推荐老师

    static constraints = {
        district nullable: true
        city nullable: true
        province nullable: true
        qq nullable: true
        tel nullable: true
        plan nullable: true
        teacher nullable: true
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
}
