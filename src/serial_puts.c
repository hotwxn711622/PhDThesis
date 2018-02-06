void serial_puts(char * s, int len) {
	int i = 0;
	while (i < len && s[i] != 0) {
		serial_intr_disable();
		serial_putc(s[i]);
		serial_intr_enable();
		i++;
	}
}