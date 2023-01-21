"! <p class="shorttext synchronized" lang="EN">Breakpoint dependent on a checkpoint group</p>
"! Implements {@link zif_checkpoint_break}
class zcl_checkpoint_break definition
                           public
                           create public.

  public section.

    interfaces: zif_checkpoint_break.

    aliases: is_active_in_any_way for zif_checkpoint_break~is_active_in_any_way,
             break for zif_checkpoint_break~break,
             breakpoint_is_active for zif_checkpoint_break~breakpoint_is_active,
             break_or_infinite_loop for zif_checkpoint_break~break_or_infinite_loop,
             asser_is_active_as_bp_or_abort for zif_checkpoint_break~asser_is_active_as_bp_or_abort,
             break_or_delay for zif_checkpoint_break~break_or_delay,
             asser_is_active_as_bp_or_log for zif_checkpoint_break~asser_is_active_as_bp_or_log.

    "!
    "! @parameter I_CHECKPOINT_ID | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_checkpoint_id type zif_checkpoint_break=>t_checkpoint_id
                i_breakpoint_active type xsdboolean
                i_asser_active_as_bp_or_log type xsdboolean
                i_asser_active_as_bp_or_abort type xsdboolean.

  protected section.

    "! <p class="shorttext synchronized" lang="EN">Associated checkpoint group ID</p>
    data a_checkpoint_id type zif_checkpoint_break=>t_checkpoint_id.

    "! <p class="shorttext synchronized" lang="EN">Checkpoint group has BP activated</p>
    data a_breakpoint_active_bool type xsdboolean.

    "! <p class="shorttext synchronized" lang="EN">Checkpoint group has assertion activated as BP (log for bg)</p>
    data an_asser_act_as_bp_or_log_bool type xsdboolean.

    "! <p class="shorttext synchronized" lang="EN">Checkpoint grp. has assertion activated as BP (abort for bg)</p>
    data an_asser_act_as_bp_or_ab_bool type xsdboolean.

ENDCLASS.



CLASS ZCL_CHECKPOINT_BREAK IMPLEMENTATION.


  method constructor.

    me->a_checkpoint_id = i_checkpoint_id.

    me->a_breakpoint_active_bool = i_breakpoint_active.

    me->an_asser_act_as_bp_or_ab_bool = i_asser_active_as_bp_or_abort.

    me->an_asser_act_as_bp_or_log_bool = i_asser_active_as_bp_or_log.

  endmethod.


  method zif_checkpoint_break~asser_is_active_as_bp_or_abort.

    r_active_as_break_or_abort = me->an_asser_act_as_bp_or_ab_bool.

  endmethod.


  method zif_checkpoint_break~asser_is_active_as_bp_or_log.

    r_active_as_break_or_log = me->an_asser_act_as_bp_or_log_bool.

  endmethod.


  method zif_checkpoint_break~break.

    if me->is_active_in_any_way( ).

      break-point. "#EC NOBREAK

    endif.

    r_self = me.

  endmethod.


  method zif_checkpoint_break~breakpoint_is_active.

    r_active_as_breakpoint = me->a_breakpoint_active_bool.

  endmethod.


  method zif_checkpoint_break~break_or_delay.

    if me->is_active_in_any_way( ).

      if not cl_gui_alv_grid=>offline( ).

        me->break( ).

      else.

        get time stamp field data(starting_timestamp).

        data(ending_timestamp) = cl_abap_tstmp=>add( tstmp = starting_timestamp
                                                     secs = i_seconds_of_delay ).

        get time stamp field data(current_timestamp).

        while current_timestamp lt ending_timestamp.

          get time stamp field current_timestamp.

        endwhile.

      endif.

    endif.

    r_self = me.

  endmethod.


  method zif_checkpoint_break~break_or_infinite_loop.

    if me->is_active_in_any_way( ).

      if not cl_gui_alv_grid=>offline( ).

        me->break( ).

      else.

        me->break_or_delay( cl_abap_math=>max_int4 ).

      endif.

    endif.

    r_self = me.

  endmethod.


  method zif_checkpoint_break~is_active_in_any_way.

    r_active_in_any_way = xsdbool( me->breakpoint_is_active( )
                                   or me->asser_is_active_as_bp_or_abort( )
                                   or me->asser_is_active_as_bp_or_log( ) ).

  endmethod.
ENDCLASS.
