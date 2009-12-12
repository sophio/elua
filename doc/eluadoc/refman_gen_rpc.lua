-- eLua reference manual - SPI module

data_en = 
{

  -- Title
  title = "eLua reference manual - LuaRPC module",

  -- Menu name
  menu_name = "rpc",

  -- Overview
  overview = [[LuaRPC allows one to remotely control a lua state running on another machine or microcontroller.</p>
  <p>It works by providing a $handle$ to the client session which allows control over remote state. Functions can
  be called in the remote environment and variables can be manipulated by treating the $handle$ (representing 
  the remote global table) as if it were a local table.</p>
  <p>In order to open a connection, it is necessary to specify the interface through wich the connection is made.
  Currently the connections are limited to serial ports on the desktop side, and uart devices on the eLua side.
  For a number of the connections below, a parameter labeled $transport_identifiers$ is used to specify the port
  to be used in a platform specific manner:
  <ul>
    <li>eLua: $transport_identifiers$ = $uart_id$, $timer_id$
      <ul>
        <li>$uart_id$ - the ID of the serial port (as in the @refman_gen_uart.html@uart module@). This uart must already be configured using $uart.setup$ before being used in this module.</li>
        <li>$timer_id$ - the ID of the timer for send/receive timeouts (as with send/receive functions in the @refman_gen_uart.html@uart module@)</li>
      </ul>
    </li>
    <li>Linux/Mac OS X luarpc: $transport_identifiers$ = $uart_path$
      <ul>
        <li>$uart_path$ - the path to the serial port to use (e.g.: "/dev/ttyS0")</li>
      </ul>
    </li>
  </ul>
  </p>
  
  <p><span class="warning">IMPORTANT</span>: This module is considered experimental. It currently works over a 
  serial port with eLua targets and on desktop systems implementing POSIX serial communications (Linux, Mac OS X, etc).
  ]],

  -- Functions
  funcs = 
  {
    { sig = "handle = #rpc.connect#( transport_identifiers )",
      desc = "Initiate connection from client to server.",
      args = 
      {
        "$transport_identifiers$ - platform-specific serial port identification (see @#overview@overview@)"
      },
      ret = [[$handle$ - handle used to interact with the remote Lua state.  Usage styles are as follows:
              <ul>
                <li>$handle$.$remote_variable$ = $local_variable$ - send contents of $local_variable$ to remote host and assign to $remote_variable$ (registered on global table). This also works where the destination variable is nested within tables.</li>
                <li>$local_variable$ = $handle$.$remote_variable$:get() - get contents of $remote_variable$ from remote global table and assign to $local_variable$.</li>
                <li>$val1$, $val2$, $valn$ = $handle$.$remote_function$() - call $remote_function$ on the server side, and return values to local state</li>
                <li>$helper$ = $handle$.$remote_variable$ - create a $helper$ which points to $remote_variable$, and can be used as shorthand later (e.g.: $helper$:get() would get the contents of the remote variable. If $remote_variable$ were a table with functions on it: $helper$.$funcname$() would call $funcname$, on table $remote_variable$ on the server, and return any results.)</li>
              </ul>
            ]]
    },

    { sig = "#rpc.close#( handle )",
      desc = "Close an active RPC session.",
      args = "$handle$ - handle associated with the connection.",
    },

    { sig = "#rpc.server#( transport_identifiers )",
      desc = "Start a blocking/captive RPC server, which will wait for incoming connections.",
      args = "$transport_identifiers$ - platform-specific serial port identification (see @#overview@overview@)",
    },

    { sig = "#rpc.on_error#( err_handler )",
      desc = "Define client-side error handler to deal with server-side error responses.",
      args = "$err_handler$ - function to handle error messages. string error messages may be passed to this function.",
    },

    { sig = "server_handle = #rpc.listen#( transport_identifiers )",
      desc = "Open a listener on transport and await incoming connections.",
      args = "$transport_identifiers$ - platform-specific serial port identification (see @#overview@overview@)",
      ret = "server handle to use with @#rpc.peek@rpc.peek@ and @#rpc.dispatch@rpc.dispatch@"
    },
    
    { sig = "data_available = #rpc.peek#( server_handle )",
      desc = "Check if data are available to read on transport.",
      args = "$server_handle$ - handle to refer to server session, created by @#rpc.listen@rpc.listen@",
      ret = "$data_available$ - 1 if data are available, 0 if data are unavailable"
    },
    
    { sig = "#rpc.dispatch#( server_handle )",
      desc = "Read transport and handle incoming command.",
      args = "$server_handle$ - handle to refer to server session, created by @#rpc.listen@rpc.listen@",
    },
   
  },

}

data_pt = data_en

