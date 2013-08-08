package com.baoming

import com.baoming.account.Teacher

class DownloadRecord {

    Date dateCreated
    static belongsTo = [download:Download,teacher:Teacher]
    static constraints = {
        download(unique: 'teacher')
    }
}
