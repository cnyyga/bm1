package com.baoming

import com.baoming.account.User

class Welcome {

    String content
    Date dateCreated
    User user
    static constraints = {
        user nullable: true
    }

    static mapping = {
        content sqlType: 'text'
    }
}
