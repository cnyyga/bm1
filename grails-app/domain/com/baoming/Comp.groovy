package com.baoming

class Comp {

    String num
    String content
    String type
    static constraints = {
        type(maxSize: 1)
    }
    static mapping = {
        version(false)
        content(type: 'text')
        num(index: 'comp_num_Idx')
    }
}
