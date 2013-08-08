package com.baoming.account

class Role {

    static final def AUTHORITY_ADMIN = 'ROLE_ADMIN'
    static final def AUTHORITY_TEACHER = 'ROLE_TEACHER'
    static final def AUTHORITY_STUDENT = 'ROLE_STUDENT'
    static final def AUTHORITY_FINANCE = 'ROLE_FINANCE'

    String name
	String authority

	static mapping = {
		cache true
	}

	static constraints = {
        name nullable: true
		authority blank: false, unique: true
	}
}
