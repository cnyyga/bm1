package com.baoming

/**
 * 旁听生报警缺少的材料.
 * 
 * @author wenwu
 *
 */
class Material {

	String content
    String reviewStatus //审核后的状态对应的显示，可多选. 2=参加江苏省普高注册入学 3=参加江苏省中职注册入学4=挂江苏中职学籍
	
    static constraints = {
		content(maxSize:1024)
    }
	
	static mapping={
		version(false)
	}

    enum ReviewStatus{
        JSPG(2,'参加江苏省普高注册入学'),
        JSZZ(3,'参加江苏省中职注册入学') ,
        GJSZZ(4,'挂江苏中职学籍')

        Integer id
        String label

        ReviewStatus(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
