describe 'Visit Pages' do
  specify do
    visit '/'

    expect( current_path ).to eq '/'
  end

  specify do
    visit '/about'

    expect( current_path ).to eq '/about'
  end

  specify do
    visit '/donate'

    expect( current_path ).to eq '/donate'
  end

  specify do
    visit '/photos'

    expect( current_path ).to eq '/photos'
  end

  specify do
    visit '/admin'

    expect( current_path ).to eq '/admin'
  end
end
