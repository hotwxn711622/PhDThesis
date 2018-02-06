void serial_init() {
	// Turn off interrupt.
	serial_write(COM1 + COM_LCR, 0); // set DLAB to zero
	serial_write(COM1 + COM_IER, 0);

	// Set DLAB.
	serial_write(COM1 + COM_LCR, COM_LCR_DLAB);

	// Set baud rate.
	serial_write(COM1 + COM_DLL, 0x0001ul);
	serial_write(COM1 + COM_DLM, 0x0000ul);

	// Set the line status.
	serial_write(COM1 + COM_LCR, COM_LCR_WLEN8_AND_DLAB);

	// Enable the FIFO.
	serial_write(COM1 + COM_FCR, 0xc7);

	// Turn on DTR, RTS, and OUT2.
	serial_write(COM1 + COM_MCR, 0x0b);

	// Serial COM1 doesn't exist if COM_LSR returns 0xFF.
	set_serial_exist (serial_read(COM1+COM_LSR, M_NIL) != 0xFF);

	// Clear any pre-existing overrun indications and interrupts.
	serial_read(COM1+COM_IIR, M_ALL);
	serial_read(COM1+COM_RX, M_ALL);
}
