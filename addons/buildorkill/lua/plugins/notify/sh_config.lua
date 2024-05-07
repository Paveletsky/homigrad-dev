if CLIENT then
    timer.Create('_Notifies', 700, 0, function()
        bok.gui.Notify('На двойное нажатие CTRL можно лечь на землю', 5, 'ui/hint.wav', 30, 15)
        bok.gui.Notify('Меню сервера открывается на F4.', 5, 'ui/hint.wav', 30, 15)
    end)
end