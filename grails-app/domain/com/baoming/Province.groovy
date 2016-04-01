package com.baoming

class Province {
    String code // 代码 id
    String number //编号
    String name //名称
    Integer orderValue = 0
    Status status = Status.ENABLED

    static hasMany = [citys:City]
    static constraints = {
        code()
        name()
        number(nullable: true)
    }
    static mapping = {
        version(false)
        id generator: 'assigned', name: 'code'
        sort orderValue:'desc'
        citys(sort: 'orderValue',order: 'desc')
        number(unique: true)
    }

    enum Status {
        DISABLED(0,'禁用'),
        ENABLED(1,'启用')

        Integer id
        String label

        Status(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
