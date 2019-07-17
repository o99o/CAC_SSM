//列表控件
var tableIns;
var popForm;
layui.use(["form","table"], function(){
	  var layer = layui.layer;
	  var table = layui.table;
	  tableIns =table;
	  var form = layui.form;
	  popForm=layui.form;
	  table.render({
		    elem: '#indexTable'
		        ,url: appRootPath+'/parkinfo/selectList'
		        ,method: 'post'
		        ,request: {
		       	  	pageName: 'curr' //页码的参数名称，默认：page
		       		,limitName: 'limit' //每页数据量的参数名，默认：limit
		        	} 
		        ,page:true
		        ,id: 'indexTableReload'
		        ,limit: 10
		        ,limits:[10,15,20,50]//每页条数的选择项，默认：[10,20,30,40,50,60,70,80,90]。优先级低于 page 参数中的 limits 参数。
		        ,toolbar: '#toolbarIndex'
		        ,cols: [[
		          {field:'parkCode',align: 'left', title:'停车场编号'},
		          {field:'parkName',align: 'left', title:'停车场名称'},
		          {fixed: 'right', title:'操作', align: 'left', toolbar: '#barParkInfo'}
		        ]]
	  });
	  
	  
	//搜索查询
	var $ = layui.$, active = {
		search: function(){
	      var parkCode = $('#parkCode').val();
	      var parkName = $('#parkName').val();
	      //执行重载
	      //indexTableReload为table 的id标识
	      table.reload('indexTableReload', {
	        page: {
	          curr: 1 //重新从第 1 页开始
	        }
	        ,where: {
	        	parkCode: parkCode
	            ,parkName: parkName
	        }
	      });
	    }
	};
	
	// 监听查询按钮
	 $('.indexSearch').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		  });
	 
	// 监听新增按钮
	 $('.add').on('click', function(){
		layer.open({
        	//layer提供了5种层类型。可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            type:2,
            title:"新增停车场信息",
            area: ['60%','50%'],
            content:[appRootPath+'/parkinfo/toParkInfoAdd', 'no'] //iframe的url，no代表不显示滚动条
        });
	});
	 
	//监听工具条
   table.on('tool(indexTable)', function(obj){
	   var data = obj.data;
	   //formData = data;
	    if(obj.event === 'del'){
	      layer.confirm('确定删除？', function(index){
	        var parkInfoId = obj.data.id;
	        //超级用户id
        	$.ajax({
		        type:'POST',
		        url: appRootPath+"/parkinfo/deletePark",
		        data:{"id":parkInfoId},
		        success:function(data){
		        	resultContent=data.msg;

		        	if(true==data.success){
		        		obj.del();
		        	}
		        	layui.use("layer", function(){
 		    			var resultLayer = layui.layer;
 		    			resultLayer .open({
 			        		  content: resultContent,
 			        		  btn: ['确定'],
 			        		  yes: function(resultIndex, layero){
 			        			 // 关闭本级提示框
  			 					 resultLayer.close(resultIndex);
  			 					 // 关闭上级提示框
  			 					 layer.close(index);
  			 					 // 刷新
  			 					 table.reload('indexTableReload',{page:{curr:1}});
 			        		  }
 			        		}); 
 		    			});
			        }
		    	})
	      });
	    }
  }); 
	 
});


