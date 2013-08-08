package com.baoming

class Download {
    String name
    Date date
    Date dateCreated
    Date lastUpdated
    static hasMany = [downloadRecords:DownloadRecord]
    static constraints = {
        date nullable: true
        name nullable: true
    }
}
