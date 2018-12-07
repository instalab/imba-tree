import TreeView from './comps/TreeView'

tag App
	def mount
		window:render = self:render.bind(self)
	
	def render
		<self>
			<TreeView>

Imba.mount <App>
