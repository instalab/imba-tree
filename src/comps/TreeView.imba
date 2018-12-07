const elements = [
	{id: 0, label: 'Hello World 1', parent: null},
	{id: 1, label: 'Hello World 2', parent: null},
	{id: 2, label: 'Hello World 3', parent: 1},
	{id: 3, label: 'Hello World 4', parent: 1},
	{id: 4, label: 'Hello World 5', parent: 3}
	{id: 5, label: 'Hello World 6', parent: 4}
]

let draggedElement = null

tag Element
	def render
		<self> data:label

tag TreeView
	def findElementFromId id
		for el in elements
			if el:id === id
				return el
	
	def getChildren parent
		const children = []
		for el in elements
			if parent:id === el:parent
				children.push(el)
		return children
		
	def getParent el
		for parent in elements
			if parent:id === el:parent
				return parent
		
	def dontHaveParent el
		if el:parent === undefined || el:parent === null
			return true
			
	def renderMargin e
		let margins = []
		let par = e
		while !dontHaveParent par
			par = getParent par
			const m = <div.margin data-parent=par:id>
			m:_dom.addEventListener 'dragover', self:handleDragOver
			m:_dom.addEventListener 'drop', self:handleDrop.bind(this)
			margins.push m
		return margins.reverse
			
	def renderElement e
		const el = <Element[e] data-id=e:id>
		el:_dom:draggable = true
		el:_dom.addEventListener 'dragstart', self:handleDragStart
		const els = [
			<div.line>
				renderMargin e
				el
		]
		for c in getChildren e
			for a in renderElement c
				els.push a
		return els
	
	def handleDragStart e
		draggedElement = e:target
	
	def handleDragOver e
		e.preventDefault
	
	def handleDrop e
		const elementData = findElementFromId draggedElement:dataset:id
		elementData:parent = e:target:dataset:parent
		Imba.commit

	def render
		<self>
			for e in elements
				if dontHaveParent e
					renderElement e

export TreeView
