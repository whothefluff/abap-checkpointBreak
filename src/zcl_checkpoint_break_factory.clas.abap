"! <p class="shorttext synchronized" lang="EN">{@link zif_checkpoint_break} builder</p>
class zcl_checkpoint_break_factory definition
                                   public
                                   create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns a {@link zif_checkpoint_break}</p>
    "!
    "! @parameter i_checkpoint_id | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_checkpoint_break | <p class="shorttext synchronized" lang="EN"></p>
    methods build
              importing
                i_checkpoint_id type zif_checkpoint_break=>t_checkpoint_id
              returning
                value(r_checkpoint_break) type ref to zif_checkpoint_break.

  protected section.

endclass.



class zcl_checkpoint_break_factory implementation.

  method build.

    constants nothing_active type i value 0.

    data(checkpoint) = new cl_aab_id( i_checkpoint_id ).

    checkpoint->get_all_modes( importing ex_modes_tab = data(checkpoint_group_activations)
                               exceptions others = 0 ).

    read table checkpoint_group_activations with key server = cl_abap_syst=>get_instance_name( ) assigning field-symbol(<server_activated_checkpoint>).

    if <server_activated_checkpoint> is not assigned.

      read table checkpoint_group_activations with key username = cl_abap_syst=>get_user_name( ) assigning field-symbol(<user_activated_checkpoint>).

    endif.

    data(higher_priority_act_mode) = cond #( when <server_activated_checkpoint> is assigned
                                             then <server_activated_checkpoint>-actmode
                                             when <user_activated_checkpoint> is assigned
                                             then <user_activated_checkpoint>-actmode
                                             else nothing_active ).

    cl_aab_tool=>convert_mode_to_output( exporting mode = higher_priority_act_mode
                                         importing bp_stop = data(breakpoint_active)
                                                   as_fg_stop_bg_protocol = data(asser_active_as_bp_or_log)
                                                   as_fg_stop_bg_rabax = data(asser_active_as_bp_or_abort)
                                         exceptions others = 0 ).

    r_checkpoint_break = new zcl_checkpoint_break( i_checkpoint_id = i_checkpoint_id
                                                   i_breakpoint_active = breakpoint_active
                                                   i_asser_active_as_bp_or_log = asser_active_as_bp_or_log
                                                   i_asser_active_as_bp_or_abort = asser_active_as_bp_or_abort ).

  endmethod.

endclass.
