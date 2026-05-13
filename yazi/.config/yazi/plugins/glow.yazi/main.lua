return {
    peek = function(job)
        local file = job.file.path

        ya.preview_widgets(job, {
            ui.Text.parse(io.popen("glow -s dark '" .. tostring(file) .. "'"):read("*a"))
        })
    end,
}
