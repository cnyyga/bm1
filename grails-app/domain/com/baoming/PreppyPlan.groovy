package com.baoming

/*
所属科目组
 */
class PreppyPlan {

    String name
    Status status = Status.YES
    static constraints = {
    }

    enum Status {
        NO(0,'未启用'),
        YES(1,'启用')

        Integer id
        String label

        Status(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
