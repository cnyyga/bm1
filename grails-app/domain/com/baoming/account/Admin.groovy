package com.baoming.account

class Admin  extends User{

    String name
    Date dateCreated
    static constraints = {
        name nullable: true
    }
}
