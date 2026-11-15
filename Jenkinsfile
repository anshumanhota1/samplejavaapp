
pipeline {
    agent any

    stages {

        stage('compile') {
            steps {
                echo 'compiling..'

                git url: 'https://github.com/anshumanhota1/samplejavaapp.git'

                sh script: 'mvn compile'
            }
        }

        stage('codereview-pmd') {
            steps {
                echo 'Starting PMD Code Review...'

                sh 'mvn -P metrics pmd:pmd'

                // Verify PMD report generation
                sh 'test -f target/pmd.xml'
            }

            post {
                success {
                    echo 'Publishing PMD analysis results...'

                    recordIssues(
                        enabledForFailure: true,
                        tool: pmdParser(
                            pattern: '**/target/pmd.xml'
                        )
                    )
                }
            }
        }

        stage('unit-test') {
            steps {
                echo 'unittest..'

                sh script: 'mvn test'
            }

            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('codecoverate') {
            steps {
                echo 'codecoverage..'

                sh script: 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
            }

            post {
                success {
                    cobertura(
                        autoUpdateHealth: false,
                        autoUpdateStability: false,
                        coberturaReportFile: 'target/site/cobertura/coverage.xml',
                        conditionalCoverageTargets: '70, 0, 0',
                        failUnhealthy: false,
                        failUnstable: false,
                        lineCoverageTargets: '80, 0, 0',
                        maxNumberOfBuilds: 0,
                        methodCoverageTargets: '80, 0, 0',
                        onlyStable: false,
                        sourceEncoding: 'ASCII',
                        zoomCoverageChart: false
                    )
                }
            }
        }

        stage('package') {
            steps {
                echo 'package......'

                sh script: 'mvn package'
            }
        }
    }
}
