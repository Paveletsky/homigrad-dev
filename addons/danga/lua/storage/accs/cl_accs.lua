accs = {
    ['cap'] = {
        name = 'Кепка',
        type = 'hat',
    }
    ['backpack'] = {
        name = 'Рюкзак',
        type = 'body',
    }
}

-- Функция для надевания аксессуара
local function WearAccessory(entity, accessoryIndex)
    if accs and accs[accessoryIndex] then
        entity.equipedAccs = accs[accessoryIndex]
        print("Надет аксессуар:", accs[accessoryIndex].name)
    else
        print("Аксессуар не найден.")
    end
end

-- Функция для отрисовки аксессуаров на модели
local function DrawAccessories(entity)
    if entity.equipedAccs then
        for _, accessory in pairs(entity.equipedAccs) do
            -- Предположим, что у аксессуаров есть модели в формате .mdl
            -- Здесь мы будем использовать функции render и model для отображения аксессуаров

            -- Создаем новую модель для аксессуара
            local accessoryModel = ClientsideModel("models/modified/hat07.mdl", RENDERGROUP_OPAQUE)

            -- Позиция аксессуара относительно модели игрока (это просто пример, вам нужно настроить позицию в соответствии с вашей моделью аксессуара и моделью игрока)
            local positionOffset = Vector(0, 0, 0)
            -- Угол поворота аксессуара (опять же, это пример)
            local angleOffset = Angle(0, 0, 0)

            -- Устанавливаем позицию и угол аксессуара относительно модели игрока
            accessoryModel:SetPos(entity:GetPos() + positionOffset)
            accessoryModel:SetAngles(entity:GetAngles() + angleOffset)

            -- Устанавливаем цвет аксессуара (пример использования цвета из данных аксессуара)
            accessoryModel:SetColor(Color(255, 255, 255))

            -- Рендерим аксессуар
            accessoryModel:DrawModel()

            -- Удаляем модель аксессуара после отрисовки (чтобы избежать утечек памяти)
            accessoryModel:Remove()
        end
    end
end
WearAccessory(Entity(1), 'cap')
-- Пример использования
hook.Add("PostPlayerDraw", "DrawPlayerAccessories", function(ply)
    DrawAccessories(ply)
end)
