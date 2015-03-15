package com.baoming

class ProtocolCode {

    Integer year
    Integer num
    static constraints = {
    }

    static mapping = {
        year(index: 'protocol_code_year_idx')
        version(false)
    }
}
