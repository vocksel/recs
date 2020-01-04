local Core = require(script.Parent.Parent.Core)
local defineComponent = require(script.Parent.Parent.defineComponent)

return function()
    local ComponentClass = defineComponent({
        name = "TestComponent",
        generator = function() return {} end
	})

	it("should return an array of all entities for the given component name", function()
		local core = Core.new()
		core:registerComponent(ComponentClass)

		for _=1, 10 do
			local entity = core:createEntity()
			core:addComponent(entity, ComponentClass)
		end

		expect(#core:getEntities("TestComponent")).to.equal(10)
	end)

	it("should return an empty table if no entities are found", function()
		local core = Core.new()
		core:registerComponent(ComponentClass)

		expect(core:getEntities("TestComponent")).to.be.ok()
		expect(#core:getEntities("TestComponent")).to.equal(0)
	end)

	it("should throw if the component isn't registered", function()
		local core = Core.new()

		expect(function()
			core:getEntities("TestComponent")
		end).to.throw()
	end)
end
