package com.baoming.account

class User {
	transient springSecurityService
	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password,username)
	}

    enum Gender{
        MALE(1,'男'),
        FEMALE(2,'女')

        Integer id
        String label

        Gender(Integer id,String label){
            this.id = id
            this.label = label
        }
    }

}
