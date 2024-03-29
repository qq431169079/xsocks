
#include "tcp_raw.h"

tcpRawConn *tcpRawConnNew(tcpConn *conn) {
    tcpRawConn *c;

    c = xs_realloc(conn, sizeof(*c));
    if (!c) return c;

    conn = &c->conn;

    tcpInit(conn);

    return c;
}
