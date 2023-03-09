// JQuery Plugin(IIFE)
(function($) {
	
	var $tree;
	
	var retrieveUrl = "";
	var multipleSelect = false;
	
	var prevParentNode = "";
	var refreshCallback = function() {}
	var loadedCallback = function() {}

	var tree_option;
	
	$.fn.tree_init = function(option) {
		
		$tree = this;
		if ( ! option ) {
//			return false;
		}
		
		tree_option = option;
		
		var selectCallback  = function() {}
		var moveCallback    = function() {}
		var checkCallback   = function() {}
		var uncheckCallback = function() {}
		
		if ( typeof tree_option.select_node  != "undefined" && typeof tree_option.select_node.callback  != "undefined" ) { selectCallback  = tree_option.select_node.callback; }
		if ( typeof tree_option.move_node    != "undefined" && typeof tree_option.move_node.callback    != "undefined" ) { moveCallback    = tree_option.move_node.callback;   }
		if ( typeof tree_option.check_node   != "undefined" && typeof tree_option.check_node.callback   != "undefined" ) { checkCallback   = tree_option.check_node.callback;  }
		if ( typeof tree_option.uncheck_node != "undefined" && typeof tree_option.uncheck_node.callback != "undefined" ) { uncheckCallback = tree_option.uncheck_node.callback;  }
		if ( typeof tree_option.refresh      != "undefined" && typeof tree_option.refresh.callback      != "undefined" ) { refreshCallback = tree_option.refresh.callback;     }
		if ( typeof tree_option.loaded       != "undefined" && typeof tree_option.loaded.callback       != "undefined" ) { loadedCallback  = tree_option.loaded.callback;      }
		
		retrieveTreeList(function(treeList) {

			$tree.jstree({
				"core" : {
					"check_callback" : true,
					"multiple" : tree_option.multiple_select,
					"data" : treeList
				},
				"contextmenu" : { "items" : contextMenu },
				"checkbox" : { "tie_selection" : false },
				"search": {
					"case_insensitive": false,
					"show_only_matches" : true,
					"show_only_matches_children" : true
				},
				"plugins" : tree_option.plugins
			})
			.on("select_node.jstree ", selectCallback)
			.on("move_node.jstree"   , moveCallback)
			.on("check_node.jstree"  , checkCallback)
			.on("uncheck_node.jstree", uncheckCallback)
			.on("refresh.jstree"     , refreshComplete)
			.on("loaded.jstree"      , loadedCallback);
		}, tree_option.data, tree_option.default_data);
	}
	
	$.fn.cate_tree_init = function(option) {
		$tree = this;
		tree_option = option;
		var selectCallback  = function() {}
		var moveCallback    = function() {}
		var checkCallback   = function() {}
		var uncheckCallback = function() {}
		
		if ( typeof tree_option.select_node  != "undefined" && typeof tree_option.select_node.callback  != "undefined" ) { selectCallback  = tree_option.select_node.callback; }
		if ( typeof tree_option.move_node    != "undefined" && typeof tree_option.move_node.callback    != "undefined" ) { moveCallback    = tree_option.move_node.callback;   }
		if ( typeof tree_option.check_node   != "undefined" && typeof tree_option.check_node.callback   != "undefined" ) { checkCallback   = tree_option.check_node.callback;  }
		if ( typeof tree_option.uncheck_node != "undefined" && typeof tree_option.uncheck_node.callback != "undefined" ) { uncheckCallback = tree_option.uncheck_node.callback;  }
		if ( typeof tree_option.refresh      != "undefined" && typeof tree_option.refresh.callback      != "undefined" ) { refreshCallback = tree_option.refresh.callback;     }
		if ( typeof tree_option.loaded       != "undefined" && typeof tree_option.loaded.callback       != "undefined" ) { loadedCallback  = tree_option.loaded.callback;      }
	
		retrieveCateTreeList(function(treeList) {

			$tree.jstree({
				"core" : {
					"check_callback" : true,
					"multiple" : tree_option.multiple_select,
					"data" : treeList
				},
				"types" : {
					"#" : {
						"max_children" : 1,
						"max_depth" : 4,
						"valid_children" : [ "root" ]
					},
					"root" : {
						"icon" : "/admin/resources/common/images/icon_Home.png",
						"valid_children" : [ "default" ]
					},
					"default" : {
						"icon" : "/admin/resources/common/images/icon_Favourites",
						"valid_children" : [ "default", "file" ]
					},
					"1_Y" : {
						"icon" : "/admin/resources/common/images/icon_Home.png",
						"valid_children" : []
					},
					"2_Y" : {
						"icon" : "/admin/resources/common/images/icon_Color_wheel.png",
						"valid_children" : []
					},
					"2_N" : {
						"icon" : "/admin/resources/common/images/icon_Color_wheel.png",
						"valid_children" : []
					},
					"3_Y" : {
						"icon" : "/admin/resources/common/images/icon_Favourites.png",
						"valid_children" : []
					},
					"3_N" : {
						"icon" : "/admin/resources/common/images/icon_Favourites.png",
						"valid_children" : []
					}
				},
				"contextmenu" : { 
					"items" : customMenu
				},
				"checkbox" : { "tie_selection" : false },
				"search": {
					"case_insensitive": false,
					"show_only_matches" : true,
					"show_only_matches_children" : true
				},
				"plugins" : tree_option.plugins
			})
			.on("select_node.jstree ", selectCallback)
			.on("move_node.jstree"   , moveCallback)
			.on("check_node.jstree"  , checkCallback)
			.on("uncheck_node.jstree", uncheckCallback)
			.on("refresh.jstree"     , refreshComplete)
			.on("loaded.jstree"      , loadedCallback);
		});
		
		
	}
	
	
	$.tree_reload = function(node, data) {
		
		retrieveTreeList(function(treeList) {
			
			prevParentNode = (typeof node != "undefined") ? node : "";

			$tree.jstree(true).settings.core.data = treeList;
			$tree.jstree(true).refresh();
			
		}, data, tree_option.default_data);
	}
	
	$.cate_tree_reload = function(node, data) {
		
		retrieveCateTreeList(function(treeList) {
			
			prevParentNode = (typeof node != "undefined") ? node : "";
			
			$tree.jstree(true).settings.core.data = treeList;
			$tree.jstree(true).refresh();
			
		}, data, tree_option.default_data);
	}

	$.tree_get_node = function(nodeId) {
		
		return $tree.jstree().get_node(nodeId);
	}
	
	$.tree_get_parent_node = function(nodeId) {
		
		return $tree.jstree().get_node($tree.jstree().get_parent(nodeId));
	}
	
	$.tree_get_parent = function(nodeId) {
		
		return $tree.jstree().get_parent(nodeId);
	}
	
	$.tree_get_data = function(nodeId) {
		
		return $tree.jstree().get_node(nodeId).data;
	}
	
	$.tree_is_leaf = function(nodeId) {
		
		return $tree.jstree().is_leaf(nodeId);
	}
	
	$.tree_get_checked = function() {
		
		return $tree.jstree().get_checked();
	}
	
	$.tree_get_json = function(obj, options) {
		
		return $tree.jstree().get_json(obj, options);
	}
	
	$.tree_open_all = function() {
		
		$tree.jstree().open_all();
	}
	
	$.tree_close_all = function() {
		
		$tree.jstree().close_all();
		$tree.jstree().open_node($tree.jstree().get_children_dom("#")[0].id);
	}
	
	$.tree_set_text = function(nodeId, text) {
		$tree.jstree().set_text(nodeId, text);
	}
	
	$.tree_set_data = function(nodeId, jsonData) {
		$tree.jstree().get_node(nodeId).data = jsonData;
	}
	
	$.tree_create_node = function() {
		console.log("create_node");
		$tree.jstree().create_node();
	}
	
	$.tree_node_click = function(nodeId) {
		if ( ! nodeId ) {
			nodeId = $tree.jstree().get_children_dom("#")[0].id;
		}
		
		$('#'+nodeId+'_anchor').click();
	}
	
	$.tree_search = function(thisObj) {
		var searchText = $(thisObj).eq(0).val();
		$tree.jstree('search', searchText);
	}
	
	var retrieveTreeList = function(doneCallback, requestData, defaultData) {
		
		if ( typeof tree_option.url == "undefined" ) {
			doneCallback(defaultData);
			return false;
		}
		$.ajax({
			url : tree_option.url,
			type: "POST",
			data: (typeof requestData == "undefined") ? "{}" : requestData,
			contentType: "application/json"
		}).done(function(res) {
			
			if ( typeof defaultData != "undefined" ) {
				doneCallback(res.treeList.concat(defaultData));
			} else {
				doneCallback(res.treeList);
			}
		})
		  .fail(function() {
			alert("tree init error");
		});
	}
	
	var retrieveCateTreeList = function(doneCallback, requestData, defaultData) {
		
		if ( typeof tree_option.url == "undefined" ) {
			doneCallback(defaultData);
			return false;
		}
		$.ajax({
			url : tree_option.url,
			type: "POST",
			data: (typeof requestData == "undefined") ? "{}" : requestData,
					contentType: "application/json"
		}).done(function(res) {

			if ( typeof defaultData != "undefined" ) {
				doneCallback(res.businessCateTreeList.concat(defaultData));
			} else {
				doneCallback(res.businessCateTreeList);
			}
		})
		.fail(function() {
			alert("tree init error");
		});
	}
	
	var contextMenu = function(node) {
	 
		var items = new Object();
		
		var create_item = {
			"separator_before": false,
			"separator_after": false,
			"label": "Create",
			"action": createAction
		};
		var rename_item = {
			"separator_before": false,
			"separator_after": false,
			"label": "Rename",
			"action": renameAction
		};
		
		var edit_item = {
			"separator_before": false,
			"separator_after": false,
			"label": "Edit",
			"action": editAction
		};
		var remove_item = {
			"separator_before": false,
			"separator_after": false,
			"label": "Delete",
			"action": removeAction
		};
		var disable_item = {
			"separator_before": true,
			"separator_after": false,
			"label": "Enable / Disable",
			"action": disableAction,
		};
		
		tree_option.contextmenu.items.forEach(function(element) {
			
			switch ( element ) {
			case "create": items.create = create_item; break;
			case "edit": items.edit = edit_item; break;
			case "remove": items.remove = remove_item; break;
			case "rename": items.rename = rename_item; break;
			case "disable": items.disable = disable_item; break;
			}
		});
		
		return items;
	};
	
	var createAction = function(obj) {
		
		var $tree_ref = $.jstree.reference(obj.reference);
		var sel = $tree_ref.get_selected();
		if ( !sel.length || sel.length > 1 ) { return false; }
		var $node = $tree_ref.create_node(sel[0]);
		$tree_ref.deselect_all();
		$tree_ref.select_node($node);
		
		if ( typeof tree_option.contextmenu.create.callback != "undefined" ) {
			tree_option.contextmenu.create.callback($tree_ref, $node);
		}
	}
	
	var editAction = function(obj) {
		
		var $tree_ref = $.jstree.reference(obj.reference);
		var sel = $tree_ref.get_selected();
		if ( !sel.length || sel.length > 1 ) { return false; }
		var $node = $tree_ref.get_node(sel[0]);
		
		if ( typeof tree_option.contextmenu.edit.callback != "undefined" ) {
			tree_option.contextmenu.edit.callback($tree_ref, $node);
		}
	}
	
	var removeAction = function(obj) {
		
		var $tree_ref = $.jstree.reference(obj.reference);
		var sel = $tree_ref.get_selected();
		if ( !sel.length ) { return false; }
		var $node = $tree_ref.get_node(sel[0]);
		
		if ( typeof tree_option.contextmenu.remove.callback != "undefined" ) {
			tree_option.contextmenu.remove.callback($tree_ref, $node, sel);
		}
	}
	
	var renameAction = function(obj) { 
		tree.edit(node);
		
		if ( typeof tree_option.contextmenu.rename.callback != "undefined" ) {
			tree_option.contextmenu.rename.callback($tree_ref, $node);
		}
	}
	
	var disableAction = function (obj) {
		if (tree.is_disabled(node)) {
			tree.enable_node(node);
		} else {
			tree.disable_node(node);
		}
		
		if ( typeof tree_option.contextmenu.disable.callback != "undefined" ) {
			tree_option.contextmenu.disable.callback($tree_ref, $node);
		}
	}
	
	var refreshComplete = function(e, data) {
		
		var $tree_instance = data.instance;
		
		var selectedNode = $tree_instance.get_selected();
		if ( selectedNode.length == 0 ) {
			
			var $parentNode = $tree_instance.get_node(prevParentNode);
			if ( $parentNode ) {
				if ( $parentNode.children.length == 0 ) {
					// Child Menu가 없을 경우 Parent 선택
					$tree_instance.select_node($parentNode.id);
				} else {
					// Child Node가 있는 경우 마지막 Node 선택
					$tree_instance.select_node($parentNode.children[$parentNode.children.length - 1]);
				}
			}
		} else {
			// 부모 노드가 닫혀 있을 때 열어줌.
			var parentNodeId = $tree_instance.get_parent(selectedNode[0]);
			if ( false == $tree_instance.is_open(parentNodeId) ) {
				$tree_instance.open_node(parentNodeId);
			}
		}
		
		refreshCallback();
	}
/*	
	$(document).on("dnd_start.vakata", function(e, data) {
		// console.log("start", data.data.origin.get_node(data.element), data.data.origin.get_parent(data.element));
	}).on("dnd_stop.vakata", function(e, data) {
		console.log("stop", data.data.origin);
		// console.log("stop", data.data.origin.get_node(data.element), data.data.origin.get_parent(data.element));

		console.log("data ", data.data);
		
		var tree = data.data.origin;
		
		var node = tree.get_node(data.element);
		
		console.log("node : " + node.id + ", node.parent : " + node.parent + ", node.original.parent : " + node.original.parent);
		
		console.log(tree.get_parent(data.element));
		console.log(tree.get_node(tree.get_parent(data.element)));
	});
*/
})(jQuery);