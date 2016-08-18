node 'graylog-mongo01', 'graylog-mongo02', 'graylog-mongo03' {
	include '::mongodb::server'
}


node 'default' {
		notify{ 'Default node':
		}
}
