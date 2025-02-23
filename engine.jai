Modules :: #bake_arguments Mixer(procs=.[
    .{"init", .[*World]},
    .{"tick", .[*World]},
    .{"deinit", .[*World]}
]);

Engine_T :: struct {
    world: World = .{};
    system_threads: Thread_Group = .{};
    is_running: bool = false;
}

Engine :: struct($modules: Type) #modify {
    t_info := cast(*Type_Info)modules;

    if t_info.type != .STRUCT then return false;
    s_info := cast(*Type_Info_Struct)modules;

    if s_info.polymorph_source_struct != cast(*Type_Info_Struct)Modules {
        print("\x1b[31m[Error] Unknown modules type:\x1b[0m %\n", modules);
        return false;
    }
    return true;
} {
    #as using base: Engine_T = .{};
}

engine: *Engine_T;


run :: (in_engine: *Engine) {
    engine = *in_engine.base;

    engine.modules.init(enigne.world);

    while.engine.is_running {
        engine.modules.tick(enigne.world);
    }

    engine.modules.deinit(engine.world);
}