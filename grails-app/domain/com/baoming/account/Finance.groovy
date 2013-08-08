package com.baoming.account

class Finance extends User{

    String name
    Date dateCreated
    static constraints = {
        name nullable: true
    }
}
