package com.baoming

class Comp {

    String num
    String content
    String type
    String uid
    static constraints = {
        type(maxSize: 1)
        uid(nullable: true)
    }
    static mapping = {
        version(false)
        content(type: 'text')
        num(index: 'comp_num_Idx')
    }
}
