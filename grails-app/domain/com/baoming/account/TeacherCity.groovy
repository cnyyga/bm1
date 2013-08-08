package com.baoming.account

import com.baoming.City

class TeacherCity {
    static belongsTo = [city:City,teacher:Teacher]
    static constraints = {
        city(unique: 'teacher')
    }
    static mapping = {
        version(false)
    }
}
