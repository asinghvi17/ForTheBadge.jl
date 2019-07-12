using ForTheBadge
using Test

testdir = "$(@__DIR__)/../assets/tests"

ispath(testdir) && rm(testdir, recursive = true)
ispath(testdir) || mkpath(testdir)

cd(testdir)

@testset "create badges" begin
    @test_nowarn badge("FOR THE", "BADGE")
end
