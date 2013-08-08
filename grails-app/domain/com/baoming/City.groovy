package com.baoming

class City {

    String name
    String code
    String number //编号
    Integer orderValue = 0
    static belongsTo = [province:Province]
    static hasMany = [districts:District]
    static constraints = {
        code()
        name()
        province()
        number(nullable: true)
    }
    static mapping = {
        version(false)
        id generator: 'assigned', name: 'code'
        sort orderValue:'desc'
        districts(sort: 'orderValue',order: 'desc')
        number(unique: true)
    }
}
