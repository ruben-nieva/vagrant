node 'graylog-mongo01' {
	include '::mongodb::server'

}

node 'default' {
		notify{ 'Default node':
		}
}
