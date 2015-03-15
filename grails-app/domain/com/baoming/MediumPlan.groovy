package com.baoming

class MediumPlan {

    String code // 代码
    String name //名称
    Date dateCreated
    Status status = Status.RUNNING
    Integer orderValue = 0

    static constraints = {

    }

    static mapping = {
        orderValue index: 'orderValue_idx'
        sort orderValue:'desc'
    }
    enum Status {
        WAITING(0,'未启用'),
        RUNNING(1,'进行中'),
        END(2,'结束')

        Integer id
        String label

        Status(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
