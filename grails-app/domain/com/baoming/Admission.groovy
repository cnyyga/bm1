package com.baoming

class Admission {

    String idNo
    String name
    String sex
    String ksh//考生号
    String bkzy//报考专业
    String jtdz//家庭地址
    String lxdh//联系电话
    String kd//快递
    String kddh//快递单号
    String bz//备注

    Date dateCreated
    Date lastUpdated

    static constraints = {
        idNo()
        name()
        sex()
        ksh()
        bkzy(nullable: true)
        jtdz(nullable: true)
        lxdh(nullable: true)
        kd(nullable: true)
        kddh(nullable: true)
        bz(nullable: true)
    }
}
