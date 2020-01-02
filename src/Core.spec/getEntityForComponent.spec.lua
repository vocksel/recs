local Core = require(script.Parent.Parent.Core)
local defineComponent = require(script.Parent.Parent.defineComponent)

return function()
    local ComponentClass = defineComponent({
        name = "TestComponent",
        generator = function()
            return {}
        end
	})

	it("should get the entity for a component", function()
		local core = Core.new()
		core:registerComponent(ComponentClass)

		local entity = core:createEntity()
		local _, component = core:addComponent(entity, ComponentClass)

        expect(core:getEntityForComponent(component)).to.equal(entity)
	end)

	it("should get the entity for a component when there are many entities", function()
		local core = Core.new()
		core:registerComponent(ComponentClass)

		local entities = {}
		for i=1, 10 do
			local entity = core:createEntity()
			core:addComponent(entity, ComponentClass)

			table.insert(entities, entity)
		end

		local lastEntity = entities[#entities]
		local component = core:getComponent(lastEntity, ComponentClass.className)

		expect(core:getEntityForComponent(component)).to.equal(lastEntity)
	end)
end
