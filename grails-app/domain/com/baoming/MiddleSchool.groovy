package com.baoming

class MiddleSchool {
    String code // 代码
    String name //名称
    String contact //联系人
    String tel  //电话
    String description //备注
    static belongsTo = [district:District]    //关联到区县
    static constraints = {
    }

    static mapping = {
        version(false)
    }
}
