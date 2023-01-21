"! <p class="shorttext synchronized" lang="EN">Breakpoint dependent on a checkpoint group</p>
interface zif_checkpoint_break public.

  "! <p class="shorttext synchronized" lang="EN">Checkpoint group name</p>
  types t_checkpoint_id type aab_id_name.

  "! <p class="shorttext synchronized" lang="EN">Call break-point statement</p>
  "!
  "! @parameter R_SELF | <p class="shorttext synchronized" lang="EN"></p>
  methods break
            returning
              value(r_self) type ref to zif_checkpoint_break.

  "! <p class="shorttext synchronized" lang="EN">Call break-point statement (infinite loop if bg process)</p>
  "!
  "! @parameter R_SELF | <p class="shorttext synchronized" lang="EN"></p>
  methods break_or_infinite_loop
            returning
              value(r_self) type ref to zif_checkpoint_break.

  "! <p class="shorttext synchronized" lang="EN">Call break-point statement (commit-less wait if bg process)</p>
  "!
  "! @parameter I_SECONDS_OF_DELAY | <p class="shorttext synchronized" lang="EN"></p>
  "! @parameter R_SELF | <p class="shorttext synchronized" lang="EN"></p>
  methods break_or_delay
            importing
              i_seconds_of_delay type i default 60
            returning
              value(r_self) type ref to zif_checkpoint_break.

  "! <p class="shorttext synchronized" lang="EN">Checkpoint group has BP activated</p>
  "!
  "! @parameter R_ACTIVE_AS_BREAKPOINT | <p class="shorttext synchronized" lang="EN"></p>
  methods breakpoint_is_active
            returning
              value(r_active_as_breakpoint) type xsdboolean.

  "! <p class="shorttext synchronized" lang="EN">Checkpoint group has assertion activated as BP (log for bg)</p>
  "!
  "! @parameter R_ACTIVE_AS_BREAK_OR_LOG | <p class="shorttext synchronized" lang="EN"></p>
  methods asser_is_active_as_bp_or_log
          returning
            value(r_active_as_break_or_log) type xsdboolean.

  "! <p class="shorttext synchronized" lang="EN">Checkpoint grp. has assertion activated as BP (abort for bg)</p>
  "!
  "! @parameter R_ACTIVE_AS_BREAK_OR_ABORT | <p class="shorttext synchronized" lang="EN"></p>
  methods asser_is_active_as_bp_or_abort
            returning
              value(r_active_as_break_or_abort) type xsdboolean.

  "! <p class="shorttext synchronized" lang="EN">Checkpoint group has anything activated as BP</p>
  "!
  "! @parameter R_ACTIVE_IN_ANY_WAY | <p class="shorttext synchronized" lang="EN"></p>
  methods is_active_in_any_way
            returning
              value(r_active_in_any_way) type xsdboolean.

endinterface.
