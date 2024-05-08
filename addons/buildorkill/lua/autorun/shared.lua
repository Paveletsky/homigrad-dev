bok.util.IncludeDir("core/libs")

bok.util.IncludeDir("core/libs/client")
bok.util.IncludeDir("core/libs/server")
bok.util.IncludeDir("core/libs/utils")

bok.util.IncludeDir("core/vgui")
bok.util.IncludeDir("core/derma")

bok.util.IncludeDir("core/hooks")

hook.Add('Initialize', 'bkInit', function(arguments)
	bok.plugin.Initialize()
	hook.Run('dangautils.run')
end)
