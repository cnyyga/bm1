package com.baoming.account

import com.baoming.District

class TeacherDistrict {

    static belongsTo = [district:District,teacher:Teacher]
    static constraints = {
        district(unique: 'teacher')
    }
    static mapping = {
        version(false)
    }
}
